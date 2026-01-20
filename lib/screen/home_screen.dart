import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video != null
        ? _VideoPlayer(video: video!,)
        : _VideoSelector(onLogoTap: onLogoTap),
    );
  }

  onLogoTap() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery
    );
    setState(() {
      this.video = video;
    });
  }

}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTap;
  const _VideoSelector({
    required this.onLogoTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff2a3a7c), Color(0xff000118)],
          // stops: [0.2, 0.8],
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onLogoTap,
          ),
          SizedBox(height: 20),
          _Title(),
        ],
      ),
    );
  }
}


class _Logo extends StatelessWidget {
  final VoidCallback onTap;
  const _Logo({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('asset/img/logo.png'),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 32.0,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('VIDEO', style: textStyle),
        Text('PLAYER', style: textStyle.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final XFile video;
  const _VideoPlayer({
    required this.video,
    super.key,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late final VideoPlayerController videoPlayerController;
  // null로 선언할 건 아니지만 선언 위치에서 초기화하고 싶진 않을 때 late를 사용한다.

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  initializeController() async { // 보통 이렇게 컨트롤러 선언과 초기화를 분리해서 사용한다.
    videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );
    await videoPlayerController.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: Stack(
          children: [ // stack에 넣은 순서대로 쌓인다.
            VideoPlayer(
              videoPlayerController
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: (){},
                    icon: Icon(Icons.rotate_left),
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: (){},
                    icon: Icon(Icons.play_arrow),
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: (){},
                    icon: Icon(Icons.rotate_right),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0, // left, right: 0으로 slider를 좌우로 stretch 해줄수있음.
              child: Slider(
                  value: 0,
                  onChanged: (double val){},
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton( // 다른 영상 선택하기
                  color: Colors.white,
                  onPressed: (){},
                  icon: Icon(Icons.photo_camera_back),
              ),
            )
          ],
        ),
      ),
    );
  }
}
