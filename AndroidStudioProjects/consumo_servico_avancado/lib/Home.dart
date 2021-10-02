import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'Post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _urlbase = "https://jsonplaceholder.typicode.com";

  //Post post = Post(0, 1, "", "");

  Future<List<Post>> _recuperarPostagens() async {
    /*
    List<Post> lista = List();
    Post post = Post();
    lista.add(post);
    */

    http.Response response = await http.get (Uri.parse(_urlbase + "/posts"));
    var dadosJson = jsonDecode(response.body);
    List<Post> postagens = [];

    for (var post in dadosJson){
      print ("post: " + post["title"]);
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
    return postagens;
   //  print (postagens.toString()); // Para teste
  }

  _post () async {

    Post post = new Post(120, 2, "Título", "Corpo da postagem");

    // Retirar este código para voltar com o código abaixo e retirar o Map toJson da class Post
    var corpo = jsonEncode(
      post.toJson()
    );
    // o código acima é o mesmo do abaixo, posso trocar também nos outros métodos

   /* Este código acima foi implementado junto com o toJson na class Post, caso queira voltar o código abaixo retirar o var corpo com jSonEncode
    var corpo = jsonEncode( // recebe um objeto e retorna em string
        {
          "userId": 120,
          "id": null,
          "title": "Título",
          "body": "Corpo da postagem"
        }
    );
    */

    http.Response response = await http.post(Uri.parse(
        _urlbase + "/posts"),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: corpo
    );

    print ("resposta: ${response.statusCode}");
    print ("resposta: ${response.body}");
  }

  _put () async {
    var corpo = jsonEncode(
      {
        "userId": 120,
        "id": null,
        "title": "Título alterado",
        "body": "Corpo da postagem alterada"
      },
    );

    http.Response response = await http.put(
        Uri.parse(_urlbase + "/posts/2"),
      headers: {
      'Content-type': 'application/json; charset=UTF-8',
      },
      body: corpo
    );

    print ("resposta: ${response.statusCode}");
    print ("resposta: ${response.body}");

  }
// Diferença entre put e patch
/*put é necessário enviar o corpo todo com dados, se por nulo no title ele retornará nulo
patch não precisa de todas as informações, posso colocar apenas os campos específicos e ocultar os outros.
O resto permanece como ele já estava
 */
  _patch() async {
    var corpo = jsonEncode(
      {
        "userId": 120,
        "id": null,
        "title": null,
        "body": "Corpo da postagem alterada"
      },
    );

    http.Response response = await http.patch(
        Uri.parse(_urlbase + "/posts/2"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: corpo
    );
  }

  _delete () async {
    var corpo = jsonEncode(
      {
        "userId": 120,
        "id": null,
        "title": "Título",
        "body": "Corpo da postagem"
      },
    );

    http.Response response = await http.delete(
        Uri.parse(_urlbase + "/posts/1"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: corpo
    );

    print ("resposta: ${response.statusCode}");
    print ("resposta: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                RaisedButton(
                  child: Text("Salvar"),
                  onPressed: _post,
                ),
                RaisedButton(
                  child: Text("Atualizar"),
                  onPressed: _patch,
                ),
                RaisedButton(
                  child: Text("Remover"),
                  onPressed: _delete,
                ),
              ],
            ),
           Expanded(
               child:  FutureBuilder<List<Post>>(
                 future: _recuperarPostagens(),
                 builder: (context, snapshot){
                   var retorno;

                   switch(snapshot.connectionState){
                     case ConnectionState.none:
                     case ConnectionState.waiting:
                       return Center(
                         child: CircularProgressIndicator(),
                       );
                       break;
                     case ConnectionState.active:
                     case ConnectionState.done:
                       if (snapshot.hasError){
                         print ("lista: Erro ao carregar");
                       }
                       else{
                         return ListView.builder(
                             itemCount: snapshot.data!.length,
                             itemBuilder: (context, index){

                               List<Post>? lista = snapshot.data;
                               Post post = lista![index];

                               return ListTile(
                                 title: Text(post.title),
                                 subtitle: Text(post.id.toString()),
                               );
                             }
                         );
                       }
                       break;
                   }
                   return retorno;
                 },
               ),
           ),
          ],
        ),
      )
    );

  }
}
