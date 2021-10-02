import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main (){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recuperarBancoDados() async {
    // Caminho do Banco de Dados dentro do celular do usuário
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente){
        String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";
        db.execute(sql);
      }
    );
    
    return bd;
    //print ("aberto: " + bd.isOpen.toString());
  }
  
  _salvar() async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome" : "Maria Silva",
      "idade" : 58
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id");
  }

  _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();

    // Exemplos de comandos SQL
    //String sql = "SELECT * FROM usuarios WHERE id = 5 ";
    //String sql = "SELECT * FROM usuarios WHERE idade >= 30 AND idade <= 58";
    //String sql = "SELECT * FROM usuarios WHERE idade BETWEEN 18 AND 46 ";
    //String sql = "SELECT * FROM usuarios WHERE idade IN (18,30) ";
    //String filtro = "an";
    //String sql = "SELECT * FROM usuarios WHERE nome LIKE '%" + filtro + "%' ";
    //String sql = "SELECT *, UPPER(nome) as nomeMaiu FROM usuarios WHERE 1=1 ORDER BY UPPER(nome) DESC ";//ASC, DESC
    //String sql = "SELECT *, UPPER(nome) as nomeMaiu FROM usuarios WHERE 1=1 ORDER BY idade DESC LIMIT 3";//ASC, DESC

    String sql = "SELECT * FROM usuarios";
    List usuarios = await bd.rawQuery(sql);

    for (var usuario in usuarios){
      print ("item id: " + usuario['id'].toString() + ", nome: " + usuario['nome'] + ", idade: " + usuario['idade'].toString() + ".");
    }

   // print ("usuarios: " + usuarios.toString()); // podendo utilizar o var para percorrer a lista consome muito menos cache
  }

  _listarUsuarioPeloId(int id) async {
    Database bd = await _recuperarBancoDados();

    // CRUD -> Create, Read, Update and Delete
    List usuarios = await bd.query("usuarios",
      columns: ["id", "nome", "idade"],
      // ? é o caracter que será substituído no whereArgs
      where: "id = ?", // where: "id = ? AND nome = ? " exemplo com nome
      whereArgs: [id] // whereArgs: [id, "Jamilton Dasmasceno"] exemplo com nome
    );

    for (var usuario in usuarios){
      print ("item id: " + usuario['id'].toString() + ", nome: " + usuario['nome'] + ", idade: " + usuario['idade'].toString() + ".");
    }
  }

  _excluirUsuario(int id) async {
    Database bd = await _recuperarBancoDados();

    int retorno = await bd.delete("usuarios",
      where: "id = ?",
      whereArgs: [id]
    );

    print ("item quantidade removida: $retorno");

  }

  _atualizarUsuario(int id) async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome" : "Kaio Augusto",
      "idade" : 28
    };
    int retorno = await bd.update("usuarios",
        dadosUsuario,
      where: "id = ?",
      whereArgs: [id]
    );

    print ("item quantidade atualizada: $retorno");

  }

  @override
  void initState() {
    super.initState();

    //_salvar();
    _listarUsuarios();
    //_listarUsuarioPeloId(1);
    //_excluirUsuario(4);
    //_atualizarUsuario(1);

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
