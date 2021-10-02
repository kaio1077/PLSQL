import 'dart:math';
import 'package:flutter/material.dart';

void main (){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _frases = [
    "Sou apenas um pequeno planeta que se perde diariamente em todo o seu universo.",
    "Novas amizades serão sempre bem-vindas para darem cor e alegria ao meu dia a dia.",
    "Gratidão não é pagamento, mas um reconhecimento que se demonstra no dia a dia.",
    "Nem toda mudança importante acontece de repente e faz barulho, algumas são silenciosas e vão se fazendo no dia a dia.",
    'gustao',
    'maria carolina linda e deusa',
    'Amigo de verdade é aquele que fica feliz com sua vitória.'
  ];

  var _fraseGerada = 'Clique abaixo para gerar uma frase!';

  void _gerarFrase(){
    var numeroSorteado = Random().nextInt(_frases.length);

    setState(() {
      _fraseGerada = _frases[numeroSorteado];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frases do dia'),
        backgroundColor: Colors.green,
      ),
      body: Center( // Segunda maneira criar o center no body e na child colocar o Container
        child: Container(
          padding: EdgeInsets.all(16),
          //width: double.infinity, // Primeira maneira de resolver
       /*   decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.amber)
          ), */
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              Text(
                _fraseGerada,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    color: Colors.black
                ),
              ),
              RaisedButton(
                child: Text(
                  'Nova Frase',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                color: Colors.green,
                onPressed: _gerarFrase,
              )
            ],
          ),
        ),
      )
    );
  }
}









/* Aula Seção-10.58 - Formatação de Textos
Text(
            '"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."'
            'Não há ninguém que ame a dor por si só, que a busque e queira tê-la, simplesmente por ser dor...',
            style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
              letterSpacing: 0,
              wordSpacing: 0,
              decoration: TextDecoration.underline,
              decorationColor: Colors.greenAccent,
              decorationStyle: TextDecorationStyle.solid,
              color: Colors.black
            ),
          )
 */

/* Seção 10.59 - Botões
          FlatButton(
              onPressed: (){ // passar uma função anônima
                print('Botão pressionado');
              }, // ação do botão quando o usuário clicar em cima dele
              child: Text(
                  "Clique aqui", // definir o conteúdo do FlatButton
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  decoration: TextDecoration.none
                ),
              )
          )
 */

/* Seção 10.60 - Espaçamentos
          Text("t1"),

          Padding(
              padding: EdgeInsets.all(30),
            child: Text("t2"),
          ),

          Text("T3")
         /* Text(
              "Neque porro quisquam est qui dolorem ipsum quia dolor",
              textAlign: TextAlign.justify,
          )*/
 */

/* Seção 10.61 - Alinhamentos
Row(
        children: [
          Text('T1'),
          Text('T2'),
          Text('T3')
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      )
 */

/*Seção 10.62 - Imagens
Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.white)
      ), // definir uma borda no Container
      child: Image.asset(
        "images/port-6587129_1280.jpg",
        fit: BoxFit.none,
      ),
    )
 */

/* Seção 10.64 - Scaffold (Corpo do aplicativo, esqueleto, estrutura)
home: Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Conteúdo principal'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.greenAccent,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Text("Texto 1"),
              Text("Texto 2")
            ],
          ),
        ),
      ),
    ),
 */

/* Seção 10.64 - Widgets - Stateful e Stateless

Stateless -> Widgets que não podem ser alterados (contantes)
  Stateful -> Widgets que podem ser alterados (variáveis)

runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
  home: HomeStateful(),
  ));

}

class HomeStateful extends StatefulWidget {
  const HomeStateful({Key? key}) : super(key: key);

  @override
  _HomeStatefulState createState() => _HomeStatefulState();
}

class _HomeStatefulState extends State<HomeStateful> {
  var _texto = 'Kaio Augusto';

  @override
  Widget build(BuildContext context) {

    print ('Build chamado');
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: [
            RaisedButton(
              onPressed: (){
                setState(() {
                  _texto = 'Curso Flutter';
                });
                print('Clicado');
              },
              color: Colors.amber,
              child: Text('Clique aqui'),
            ),
            Text('Nome: $_texto')
          ],
        ),
      ),
    );
 */