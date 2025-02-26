import 'package:toktik/domain/entities/video_post.dart';

class LocalVideoModel {
  final String name;
  final String videoUrl;
  final int likes;
  final int views;
  LocalVideoModel({
    required this.name,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0,
  });

//JSON es un formato estándar para enviar y recibir datos entre un servidor y una aplicación móvil o web.
//convierte un mapa JSON en un objeto LocalVideoModel
  factory LocalVideoModel.fromJsonMap(Map<String, dynamic> json) =>
      LocalVideoModel(
          name: json['name'],
          videoUrl: json['videoUrl'],
          likes: json['likes'] ?? 0,
          views: json['views'] ?? 0);

  VideoPost toVideoPostEntity() =>
      VideoPost(caption: name, videoUrl: videoUrl, likes: likes, views: views);
}
