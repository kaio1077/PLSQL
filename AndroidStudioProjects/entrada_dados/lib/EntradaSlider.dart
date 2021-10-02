import 'package:flutter/material.dart';

class EntradaSlider extends StatefulWidget {

  @override
  _EntradaSliderState createState() => _EntradaSliderState();
}

class _EntradaSliderState extends State<EntradaSlider> {

  double _valor = 0;
  String _label = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrada Slider'),
      ) ,
      body: Container(
        padding: EdgeInsets.all(60),
        child: Column(
          children: [
            Slider(
                value: _valor,
                min: 0,
                max: 10,
                label: _label,
                divisions: 10,
                activeColor: Colors.red,
                inactiveColor: Colors.purple,
                onChanged: (double novoValor){
                  setState(() {
                    _valor = novoValor;
                    _label = novoValor.toString();
                  });
                 // print ('Valor selecionado: ' + novoValor.toString());
                }
            ),
            RaisedButton(
              child: Text(
                "Salvar",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
                onPressed: (){
                  print ('Valor selecionado: ' + _valor.toString());

                }
            )
          ],
        ),
      ),
    );
  }
}
