import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {

  String pesquisa;
  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String pesq){

    Api api = Api();
    return api.pesquisar(pesq);
  }

  // Explicação do ciclo de vida stateful - aula 106. Todos com o print: método chamado x...
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Método chamado 1 - initState");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("Método chamado 2 - didChangeDependencies");
  }

  //
  @override
  void didUpdateWidget(covariant Inicio oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("Método chamado 2 - didUpdateWidget");
  }

  // Dispose é chamado para fazer o descarte de itens que não quer mais utilizar
  // ele começa quando o método inicio dart não está mais sendo utilizado
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Método chamado 4 - dispose");
  }


  @override
  Widget build(BuildContext context) {
    print("Método chamado 3 - build"); //foi colocado apenas um print de baixo do widget build

    
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasData){
              return ListView.separated(
                  itemBuilder: (context, index){
                    List<Video>? videos = snapshot.data;
                    Video video = videos![index];
                    return GestureDetector(
                      onTap: (){
                        FlutterYoutube.playYoutubeVideoById(
                            apiKey: CHAVE_YOUTUBE_API,
                            videoId: video.id,
                          autoPlay: true,
                          fullScreen: true
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(video.imagem)
                                )
                            ),
                          ),
                          ListTile(
                            title: Text(video.titulo),
                            subtitle: Text(video.canal),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 2,
                    color: Colors.grey,
                  ) ,
                  itemCount: snapshot.data!.length
              );
            }

            else{
              return Center(
                child: Text("Nenhum dado a ser exibido"),
              );
            }
            break;
        }
      },
    );

    return Container(
      child: Center(
        child: Text(
          "Início",
          style: TextStyle(
              fontSize: 25
          ),
        ),
      ),
    );
  }
}
