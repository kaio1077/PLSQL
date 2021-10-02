import 'package:flutter/material.dart';

class EntradaSwitch extends StatefulWidget {

  @override
  _EntradaSwitchState createState() => _EntradaSwitchState();
}

class _EntradaSwitchState extends State<EntradaSwitch> {

  bool _escolhaUsuario = false;
//  bool _escolhaConfiguracao = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrada Switch'),
      ),
      body: Container(
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Receber notificações?'),
                value: _escolhaUsuario,
                onChanged: (bool valor){
                  setState(() {
                    _escolhaUsuario = valor;
                  });
                }
            ),
            RaisedButton(
              child: Text(
                'Salvar',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
                onPressed: (){
                  if(_escolhaUsuario){
                    print ('Escolha: ativar notificações');
                  }
                  else{
                    print ('Escolha: NÂO ativar notificações');
                  }
                  //print ('Resultado: ' + _escolhaUsuario.toString());
                }


            )


            /* Apenas para exemplificar que é possível mais de um SwitchListTile
            SwitchListTile(
              title: Text('Carregar imagens automaticamente'),
                value: _escolhaConfiguracao,
                onChanged: (bool valor){
                  setState(() {
                    _escolhaConfiguracao = valor;
                  });

                }
            )

             */


            /*
            Switch(
                value: _escolhaUsuario,
                onChanged: (bool valor){
                  setState(() {
                    _escolhaUsuario = valor;
                  });

                }
            ),
            Text("Receber notificações?")

             */
          ],
        ),
      ),
    );
  }
}
