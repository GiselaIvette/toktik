import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';

class DiscoverProvider extends ChangeNotifier {

  final VideoPostsRepository videoRepository; 
//cargando datos por primera vez
  bool initialLoading = true;
  //almacena los videos que se carguen
  List<VideoPost> videos = [];

  DiscoverProvider({
    required this.videoRepository
    });
//para cargar los videos
  Future<void> loadNextPage() async {
    /*simular una carga, una comunicación HTTP asíncrona.*/
    //await Future.delayed(const Duration(seconds: 2));

/*toma cada video en videoPosts, lo convierte en un LocalVideoModel usando fromJsonMap,
y luego lo transforma en una entidad VideoPost usando toVideoPostEntity.*/
    /*final List<VideoPost> newVideos = videoPosts
        .map((video) => LocalVideoModel.fromJsonMap(video).toVideoPostEntity())
        .toList();*/

final newVideos = await videoRepository.getTrendingVideosByPage(1);
  
    videos.addAll(newVideos);
    initialLoading = false;
    notifyListeners();
  }
}
