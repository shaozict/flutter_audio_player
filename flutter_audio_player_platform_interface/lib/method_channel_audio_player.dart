import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_audio_player_platform_interface/flutter_audio_player_platform_interface.dart';
import 'package:rxdart/rxdart.dart';

class MethodChannelAudioPlayer extends AudioPlayerPlatform {


  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  @override
  Future<void> init() async {}

  @override
  Future<void> open(AudioDataSource dataSource) {
    Audio audio;

    switch (dataSource.audioDataSourceType) {
      case AudioDataSourceType.asset:
        audio = Audio(
          dataSource.path,
          package: dataSource.package,
          playSpeed: dataSource.playSpeed,
        );
        break;
      case AudioDataSourceType.file:
        audio = Audio.file(
          dataSource.path,
          playSpeed: dataSource.playSpeed,
        );
        break;
      case AudioDataSourceType.network:
        audio = Audio.network(
          dataSource.path,
          playSpeed: dataSource.playSpeed,
        );
        break;
      case AudioDataSourceType.liveStream:
        audio = Audio.liveStream(
          dataSource.path,
          playSpeed: dataSource.playSpeed,
        );
        break;
    }
    return audioPlayer.open(
      audio,
      playInBackground: PlayInBackground.disabledPause,
    );
  }

  @override
  Future<void> play() {
    return audioPlayer.play();
  }

  @override
  Future<void> pause() {
    return audioPlayer.pause();
  }

  @override
  Future<void> stop() {
    return audioPlayer.stop();
  }

  @override
  Future<void> setPlaySpeed(double playSpeed) {
    return audioPlayer.setPlaySpeed(playSpeed);
  }

  @override
  ValueStream<double> get playSpeed {
    return audioPlayer.playSpeed;
  }
  @override
  ValueStream<double> get volume {
    return audioPlayer.volume;
  }

  @override
  ValueStream<bool> get isBuffering {
    return audioPlayer.isBuffering;
  }

  @override
  ValueStream<Duration> get currentPosition {
    return audioPlayer.currentPosition;
  }

  @override
  ValueStream<bool> get isPlaying => audioPlayer.isPlaying;

  @override
  ValueStream<bool> get playlistFinished => audioPlayer.playlistFinished;

  @override
  Stream<AudioPlayerState> get playerState {
   return audioPlayer.playerState.transform(StreamTransformer<PlayerState,AudioPlayerState>.fromHandlers(handleData: (data,sink){
      AudioPlayerState event = AudioPlayerState.unknown;
      switch(data){
        case PlayerState.play:
          event = AudioPlayerState.play;
          break;
        case PlayerState.pause:
          event = AudioPlayerState.pause;
          break;
        case PlayerState.stop:
          event = AudioPlayerState.stop;
          break;
      }
      sink.add(event);
    }));
  }


  @override
  Stream<AudioDataSource?> get current {
   return  audioPlayer.current.transform(StreamTransformer<Playing,AudioDataSource>.fromHandlers(handleData: (data,sink){
      sink.add(_covertPlayingAudioToAudioDataSource(data.audio));

    }));
  }

  @override
  Stream<AudioDataSource?> get onReadyToPlay {
    return audioPlayer.onReadyToPlay.transform<AudioDataSource>(StreamTransformer<PlayingAudio, AudioDataSource>.fromHandlers(handleData: (data, sink) {
      AudioDataSource audioDataSource= _covertPlayingAudioToAudioDataSource(data);
      sink.add(audioDataSource);
    }));
  }


  AudioDataSource _covertPlayingAudioToAudioDataSource(PlayingAudio data){

    AudioDataSource audioDataSource;
    switch (data.audio.audioType) {
      case AudioType.asset:
        audioDataSource = AudioDataSource.asset(data.audio.path, playSpeed: data.audio.playSpeed);
        break;
      case AudioType.network:
        audioDataSource = AudioDataSource.network(data.audio.path, playSpeed: data.audio.playSpeed);
        break;
      case AudioType.file:
        audioDataSource = AudioDataSource.file(data.audio.path, playSpeed: data.audio.playSpeed);
        break;
      case AudioType.liveStream:
        audioDataSource = AudioDataSource.liveStream(data.audio.path, playSpeed: data.audio.playSpeed);
        break;
    }

    return audioDataSource;
  }

}

