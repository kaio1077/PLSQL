import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("FloatingActionButton"),
      ),
      body: Text("Conteúdo"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     // floatingActionButton: FloatingActionButton(
      floatingActionButton: FloatingActionButton.extended( // criar um ícone com um texto
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 6,
        icon: Icon(Icons.add_shopping_cart),
        label: Text("Adicionar"),
        /*shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        Apenas para teste da modificação do botão
         */
        onPressed: (){

        },
        //mini: true,
        /*child: Icon(Icons.add),
        onPressed: (){
          print ("Resultado: botão pressionado!");
        },
        Após o mini fiz um comentário pois o extended não aceita icon como child
         */
      ),
      bottomNavigationBar: BottomAppBar(
        //shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
