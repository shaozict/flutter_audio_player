
import 'dart:io';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter_audio_player_platform_interface/flutter_audio_player_platform_interface.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerWindows extends AudioPlayerPlatform {

  static AudioPlayerWindows instance = AudioPlayerWindows()..init();
  late  Player _player ;

  final BehaviorSubject<Duration> _currentPosition =
  BehaviorSubject<Duration>.seeded(const Duration());
  final BehaviorSubject<double> _playSpeed = BehaviorSubject.seeded(1.0);


  final BehaviorSubject<double> _volume =
  BehaviorSubject<double>.seeded(1.0);

  final BehaviorSubject<bool> _isBuffering =
  BehaviorSubject<bool>.seeded(false);



  @override
  Future<void> init() async{

    DartVLC.initialize();
    _player= Player(id: 1);
  }
  @override
  Future<void> dispose()async {
    await _currentPosition.close();
    _player.dispose();
  }
  @override
  Future<void> play()async {
     _player.play();
  }
  @override
  Future<void> pause() async{
    _player.pause();
  }
  @override
  Future<void> open(AudioDataSource dataSource)async {
    Media media ;
    switch(dataSource.audioDataSourceType){
      case AudioDataSourceType.asset:
        String assetUrl = dataSource.path;
        if (dataSource.package != null && dataSource.package!.isNotEmpty) {
          assetUrl = 'packages/${dataSource.package}/$assetUrl';
        }
        media = Media.asset(assetUrl);
        break;
      case AudioDataSourceType.file:
        media = Media.file(File(dataSource.path));
        break;
      case AudioDataSourceType.liveStream:
      case AudioDataSourceType.network:
        media = Media.network(dataSource.path);

    }
   _player.open(media);

  }

  @override
  ValueStream<double> get playSpeed {
    _playSpeed.add(_player.general.rate);
    return _playSpeed.stream;
  }
  @override
  ValueStream<double> get volume  {
   _volume.add(_player.general.volume);
   return _volume.stream;
  }

  @override
  ValueStream<bool> get isBuffering {
    _isBuffering.add(!(_player.bufferingProgress == 100));
    return _isBuffering.stream;
  }

  @override
  ValueStream<Duration> get currentPosition {
    _currentPosition.add(_player.position.position??Duration.zero);
   return _currentPosition.stream;
  }

  // Stream<AudioDataSource?> get onReadyToPlay {
  //   _player.current.media
  // }
  // @override
  // Stream<AudioDataSource?> get onReadyToPlay => super.onReadyToPlay;
  //
}
