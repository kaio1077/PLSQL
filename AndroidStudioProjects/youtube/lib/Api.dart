import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyB2acfXEgr_iVtUCIMpTOOgCWaKx_W8l9g";
const ID_CANAL = "UCwXdFgeE9KYzlDdR7TG9cMw";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async{
    http.Response response = await http.get(
        Uri.parse(URL_BASE + "search"
            "?part=snippet" //somente o primeiro coloca "?"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa"
        )
    );

    if(response.statusCode == 200){
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson["items"].map<Video>(
          (map){
            return Video.fromJson(map);
            //return Video.converterJson(map);
          }
      ).toList();

      return videos;
      // print ("Resultado: " + videos.toString());

      /* Apenas para ver que podemos exibir os vídeos
      for (var video in videos){
        print ("resultado: " + video.titulo);
      }

       */

      /* o for foi comentado pois há uma outra maneira de fazer com a List<Video>
      for (var video in dadosJson["items"]){
        print ("Resultado: " + video.toString());
      }

       */
     // print ("resultado: " + dadosJson["items"][0]["snippet"]["title"].toString());

    }
    else {

    }

    // Quando houver problema de variável nula, adicionar um return chamando a variável antes de fechar a classe com chaves
    return pesquisar(pesquisa);

  }
}