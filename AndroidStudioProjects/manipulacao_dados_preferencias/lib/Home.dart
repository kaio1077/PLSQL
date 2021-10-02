import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textoSalvo = "Nada salvo!";
  TextEditingController _controllerCampo = TextEditingController();

  _salvar() async {
    String valorDigitado = _controllerCampo.text;
    final prefs = await SharedPreferences.getInstance(); // salvar, recuperar ou remover dados
    await prefs.setString("nome", valorDigitado ); //índice e valor
    print ("operacao (salvar): $valorDigitado");
  }

  _recuperar() async {
    final prefs = await SharedPreferences.getInstance(); // salvar, recuperar ou remover dados
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? ""; // para adicionar alguma mensagem se for nulo
    });
    print("operacao (recuperar): $_textoSalvo");
  }

  _remover() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");

    print ("operacao(remover): $_textoSalvo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              _textoSalvo,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite algo"
              ),
              controller: _controllerCampo,
            ),
            Row(
              children: [
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      fontSize: 12
                      ),
                    ),
                    onPressed: _salvar,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Recuperar",
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                  onPressed: _recuperar,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Remover",
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                  onPressed: _remover,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
