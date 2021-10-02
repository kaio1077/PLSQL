import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alcool_gasolina extends StatefulWidget {
  const Alcool_gasolina({Key? key}) : super(key: key);

  @override
  _Alcool_gasolinaState createState() => _Alcool_gasolinaState();
}

class _Alcool_gasolinaState extends State<Alcool_gasolina> {

  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();
  String _textoResultado = '';

  void _calcular(){

    double precoAlcool = double.parse(_controllerAlcool.text);
    double precoGasolina = double.parse(_controllerGasolina.text);
    // Verificação para saber se o número é inválido. Exemplo: usar vírgula no número decimal
    if(precoAlcool == null || precoGasolina == null){
      setState(() {
        _textoResultado = 'Número inválido, digite números maiores que 0 e'
            'utilizando ponto(.)';
      });
    }
    else{
      /*
      Se o preço do álcool dividido pelo preço da gasolina for >= 0.7
      é melhor abastecer com gasolina, senão é melhor álcool
       */
      if ((precoAlcool / precoGasolina) >= 0.7){
        setState(() {
          _textoResultado = "Melhor abastecer com gasolina!";
        });
      }
      else {
        setState(() {
          _textoResultado = "Melhor abastecer com álcool!";
        });
      }

    //  _limparCampos();

    }

  }

  void _limparCampos (){
    _controllerGasolina.text = '';
    _controllerAlcool.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Álcool ou Gasolina'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("imagens/logo1.png"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Saiba qual a melhor maneira de abastecer seu carro",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),

                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Preço Álcool, ex: 1.59"
                ),
                style: TextStyle(
                    fontSize: 18
                ),
                controller: _controllerAlcool,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Preço Gasolina, ex: 3.59"
                ),
                style: TextStyle(
                    fontSize: 18
                ),
                controller: _controllerGasolina, // capturar um campo de texto
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  onPressed: _calcular
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _textoResultado,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
