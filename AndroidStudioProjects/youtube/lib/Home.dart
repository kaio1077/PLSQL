import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricoes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricoes(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
            "imagens/youtube.png",
          width: 98,
          height: 24,
        ),
        actions: [
         /* IconButton(
              onPressed: (){
                print("acao: videocam");
              },
              icon: Icon(Icons.videocam)
          ),

          */
          IconButton(
              onPressed: () async {
                String? res = await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate()
                );
                setState(() {
                  _resultado = res!;
                });
                print  ("resultado: digitado " + res!);
              },
              icon: Icon(Icons.search)
          ),
          /*
          IconButton(
              onPressed: (){
                print("acao: conta");
              },
              icon: Icon(Icons.account_circle)
          ),

           */
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            title: Text("Início"),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            title: Text("Em alta"),
            icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            title: Text("Inscrições"),
            icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.yellow,
              title: Text("Biblioteca"),
              icon: Icon(Icons.folder)
          ),
        ],
      ),
    );
  }
}
