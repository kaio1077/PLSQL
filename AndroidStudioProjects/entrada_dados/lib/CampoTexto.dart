import 'package:flutter/material.dart';

class CampoTexto extends StatefulWidget {

  @override
  _CampoTextoState createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Entrada de dados'
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(32),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Digite um valor'
              ),
              //enabled: true,
              //maxLength: 5,
              //maxLengthEnforcement: true,
              /*style: TextStyle(
                fontSize: 25,
                color: Colors.lightBlue
              ),*/
              //obscureText: false, // Ele vai escondendo os dígitos se for true
             /* onChanged: (String texto){
                print ('valor digitado: ' + texto);
              },*/
              onSubmitted: (String texto){
                print ('valor digitado: ' + texto);
              },
              controller: _textEditingController,
            ),
          ),
          RaisedButton(
            child: Text('Salvar'),
            color: Colors.lightBlueAccent,
            onPressed: (){
              print ('valor digitado' + _textEditingController.text);
            },
          )
        ],
      ),
    );
  }
}
