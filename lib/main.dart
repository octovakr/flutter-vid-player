import 'package:flutter/material.dart';
import 'package:vid_player/screen/home_screen.dart';
// 프로젝트에서 사용할 플러그인 이름이 video_player이므로
// 프로젝트 이름은 vid_player로 했음.

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    )
  );
}