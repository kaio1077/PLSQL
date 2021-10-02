import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Frases do dia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _numeroAleatorio = 0;
  List _frases = [
    'O importante não é vencer todos os dias, mas lutar sempre.', // Item 0
    'É melhor conquistar a si mesmo do que vencer mil batalhas.', // Item 1
    'O medo de perder tira a vontade de ganhar.', // Item 2
    'Perder para a razão, sempre é ganhar.'  // Item 3
  ];

  void _incrementCounter() {
    setState(() {
      _numeroAleatorio = new Random().nextInt(4); //0,1 2,3

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pressione o botão para gerar uma frase:',
            ),
            Text(
              _frases[_numeroAleatorio], // Dentro dos colchetes, eu coloco o número do item das frases para iniciar, mas quero gerar um número aleatório
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
