import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _listaTarefas = [];
  TextEditingController _controllerTarefa = TextEditingController();
  Map<String, dynamic> _ultimaTarefaRemovida = Map();

  Future <File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();
    // print ("Caminho: " + diretorio.path);

    // Criar dados
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = "Estudar";
    tarefa["realizada"] = false;
   // _listaTarefas.add(tarefa);

    String dados = json.encode(_listaTarefas); // converter lista de objetos em json
    arquivo.writeAsString(dados);

  }

  _lerArquivo() async {
    try{
      final arquivo = await _getFile();
      return arquivo.readAsString();
    }
    catch(e){
      return null;
    }
  }

  _salvarTarefa(){
    String textoDigitado = _controllerTarefa.text;

    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;


    setState(() {
      _listaTarefas.add(tarefa);
    });


    _salvarArquivo();
    _controllerTarefa.text = "";
  }

  @override
  void initState() {
    super.initState();

    _lerArquivo().then((dados){
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

  Widget criarItemLista(context, index){
    //final item = _listaTarefas[index]["titulo"]; se usarmos essa chave que vai se repetir, depois excluirmos e adicionarmos novamente pelo desfazer causará o erro pois senão causará o erro: dismissible widget is still part of the tree
    final item = DateTime.now().microsecondsSinceEpoch.toString(); // para gerar sempre uma chave diferente

    return Dismissible(
        key: Key(item), // esta chave nunca pode ser repetida,
        direction: DismissDirection.endToStart,
        onDismissed: (direction){

          //recuperar o último item excluído antes dele ser excluído
          _ultimaTarefaRemovida = _listaTarefas[index];

          //Remove item da lista
          _listaTarefas.removeAt(index);
          _salvarArquivo();

          // snackbar de recuperação do último arquivo
          final snackbar = SnackBar(
            duration: Duration(seconds: 5),
              content: Text("Tarefa removida"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: (){
                //Insere novamente o item removido
                setState(() {
                  _listaTarefas.insert(index, _ultimaTarefaRemovida);
                });
                _salvarArquivo();
              },
            ),
          );
          Scaffold.of(context).showSnackBar(snackbar);
        },
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
        child: CheckboxListTile(
            title: Text(_listaTarefas[index]["titulo"]),
            value: _listaTarefas[index]["realizada"],
            onChanged: (valorAlterado){
              setState(() {
                _listaTarefas[index]['realizada'] = valorAlterado;
              });
              _salvarArquivo();
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    //print("itens: " + DateTime.now().microsecondsSinceEpoch.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text("Adicionar Tarefa"),
                  content: TextField(
                    controller: _controllerTarefa,
                    decoration: InputDecoration(
                      labelText: "Digite sua tarefa"
                    ),
                    onChanged: (text){

                    },
                  ),
                  actions: [
                    FlatButton(
                      child: Text("Cancelar"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text("Salvar"),
                      onPressed: (){
                        // salvar
                        _salvarTarefa();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: _listaTarefas.length,
                  itemBuilder: criarItemLista


                  /*
                    return ListTile(
                      title: Text(_listaTarefas[index]["titulo"]),
                    );
                    Comentário para testar o CheckboxListTile
                   */

              ),
          )
        ],
      ),
    );
  }
}
