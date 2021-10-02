import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {

  String valor;

  Resultado(this.valor);

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  @override
  Widget build(BuildContext context) {

   // print(widget.valor);
    var caminhoImagem = '';
    if(widget.valor == 'cara'){
      caminhoImagem = 'imagens/moeda_cara.png';
    }
    else{
      caminhoImagem = 'imagens/moeda_coroa.png';
    }

    return Scaffold(
      backgroundColor: Color(0xff61bd86), // código hexadecimal com o prefixo necessário (0xff) e depois o código hexadecimal
      // backgroundColor: Color.fromRGBO(255, 204, 128, 0),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(caminhoImagem),
            GestureDetector(
              onTap: (){
                Navigator.pop(context); // pop fecha a tela atual e retorna a tela da pilha anterior
              },
              child: Image.asset("imagens/botao_voltar.png"),
            )
          ],
        ),
      ),
    );
  }
}
