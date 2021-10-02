import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(
          onPressed: (){
            query = "";
          },
          icon: Icon(Icons.clear)
      ),

    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return  IconButton(
      onPressed: (){
        close(context, "");
      },
      icon: Icon(Icons.arrow_back)
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    print("resultado: pesquisa realizada");
    close(context, query);
    return Container();
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //print("resultado: digitado " + query);

    return Container();

    /* Apenas para exemplificar como funcionaria o suggestion
    List<String> lista = []; // List(); era assim quando não havia o null safety

    if (query.isNotEmpty){
      lista = [
        "Android", "Android navegação", "IOS", "Jogos"
      ].where(
              (texto) => texto.toLowerCase().startsWith(query.toLowerCase())
      ).toList();

      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                close(context, lista[index]); // index.toString() -> ao clicar ele já faz a busca e na maneira lista[index] apenas vai a sugestão para o search
              },
              title: Text(lista[index]),
            );
          }
      );
    }
    else{
      return Center(
        child: Text("Nenhum resultado para a pesquisa!"),
      );

    }
    */

    throw UnimplementedError();
  }

}