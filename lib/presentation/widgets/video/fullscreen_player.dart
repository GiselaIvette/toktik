import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/video_bacground.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;
  const FullscreenPlayer(
      {super.key, required this.videoUrl, required this.caption});

  @override
  State<FullscreenPlayer> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  //controlador
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0) // Silencia el video
      ..setLooping(true) // Repite el video
      ..play(); // Inicia reproducción automática
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  } //para evitar fuga de memoria , que el video no se reproduza. Evitar reproducción en segundo plano liberando el controlador

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //Permite mostrar una pantalla de carga mientras el video se inicializa.
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
              //Muestra un Loader mientras carga
              child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.green,
          ));
        }

        return GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
              return;
            }
            controller.play();
          },
          child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(controller),
                  //gradiente
                  VideoBacground(
                    stops: const [0.8, 1.0],
                  ),
                  //texto
                  Positioned(
                      bottom: 50,
                      left: 20,
                      child: _VideoCaption(caption: widget.caption))
                ],
              )),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;
  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return SizedBox(
      width: size.width * 06,
      child: Text(caption, maxLines: 2, style: titleStyle),
    );
  }
}

//StatefulWidget permite manejar el estado del video.
// Se usa FutureBuilder para mostrar un loader mientras se inicializa, y dispose() para liberar recursos.
