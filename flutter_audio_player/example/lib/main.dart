import 'package:flutter/material.dart';
import 'package:flutter_audio_player/flutter_audio_player.dart';
import 'package:flutter_audio_player_platform_interface/flutter_audio_player_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  await AudioPlayer().open(AudioDataSource.network(
                      'https://aiteacher-teaching-resource-1251316161.file.myqcloud.com/private/edudata/product/oxford/v2/followReadMp3/917e23f1abc732398dbc740a0a068a91/0027_11.mp3'));
                },
                child: Text('open'),
              ),
              TextButton(
                onPressed: () async {
                  await AudioPlayer().play();
                },
                child: Text('play'),
              ),
              TextButton(
                onPressed: () async {
                  await AudioPlayer().pause();
                },
                child: Text('pause'),
              ),
              // ProgressIndicator(
              //   color: Colors.yellow,
              //   value: AudioPlayer().currentPosition,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
