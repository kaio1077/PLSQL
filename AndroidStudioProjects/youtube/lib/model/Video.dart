class Video {
  String id;
  String titulo;
  String descricao;
  String imagem;
  String canal;

  Video({this.id = "", this.titulo = "", this.descricao = "", this.imagem = "", this.canal = ""});
/*Esse trecho de código resolve o problema, porém não é otimizado por ter que carregar 20 instâncias. Imagina 100 vídeos carregados na memória
  static converterJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"]
    );
  }

 */

  // factory retorna um único objeto, mudando os valores e retornando um vídeo diferente, otimizando por usar uma única instãncia
  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      descricao: json["snippet"]["description"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelTitle"]
    );
  }
}