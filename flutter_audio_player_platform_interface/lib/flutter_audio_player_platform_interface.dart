// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_player_platform_interface/audio_data_source.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:rxdart/rxdart.dart';

import 'method_channel_audio_player.dart';

abstract class AudioPlayerPlatform extends PlatformInterface {
  AudioPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  /// The default instance of [AudioPlayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAudioPlayer].
  static AudioPlayerPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [MethodChannelAudioPlayer] when they register themselves.
  static set instance(AudioPlayerPlatform value) {
    if (!value.isMock) {
      try {
        value._verifyProvidesDefaultImplementations();
      } on NoSuchMethodError catch (_) {
        throw AssertionError('Platform interfaces must not be implemented with `implements`');
      }
    }
    _instance = value;
  }

  static AudioPlayerPlatform _instance = MethodChannelAudioPlayer();

  /// Only mock implementations should set this to true.
  ///
  /// Mockito mocks are implementing this class with `implements` which is forbidden for anything
  /// other than mocks (see class docs). This property provides a backdoor for mockito mocks to
  /// skip the verification that the class isn't implemented with `implements`.
  @visibleForTesting
  bool get isMock => false;

  ///初始化
  Future<void> init() async {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> dispose() async {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  Future<void> open(AudioSource dataSource) async {
    throw UnimplementedError('open() has not been implemented.');
  }

  ValueStream<double> get playSpeed {
    throw UnimplementedError('playSpeed() has not been implemented.');
  }

  ValueStream<double> get volume {
    throw UnimplementedError('volume() has not been implemented.');
  }

  ValueStream<bool> get isBuffering {
    throw UnimplementedError('isBuffering() has not been implemented.');
  }

  ValueStream<bool> get isPlaying {
    throw UnimplementedError('isPlaying() has not been implemented.');
  }

  ValueStream<Duration> get currentPosition {
    throw UnimplementedError('currentPosition() has not been implemented.');
  }

  Stream<AudioPlayerState> get playerState {
    throw UnimplementedError('playerState() has not been implemented.');
  }

  Stream<AudioDataSource?> get onReadyToPlay {
    throw UnimplementedError('currentPosition() has not been implemented.');
  }

  ValueStream<AudioDataSource?> get current {
    throw UnimplementedError('current() has not been implemented.');
  }

  ///播放
  Future<void> play() async {
    throw UnimplementedError('play() has not been implemented.');
  }

  Future<void> pause() async {
    throw UnimplementedError('pause() has not been implemented.');
  }

  Future<void> seek(Duration to) async {
    throw UnimplementedError('seek() has not been implemented.');
  }

  ValueStream<bool> get playlistFinished {
    throw UnimplementedError('playlistFinished() has not been implemented.');
  }

  Future<void> stop() async {
    throw UnimplementedError('stop() has not been implemented.');
  }

  /// Change the current play speed (rate) of the MediaPlayer
  ///
  /// MIN : 0.0
  /// MAX : 16.0
  ///
  /// if null, set to defaultPlaySpeed (1.0)
  ///
  Future<void> setPlaySpeed(double playSpeed) async {
    throw UnimplementedError('setPlaySpeed() has not been implemented.');
  }

  void _verifyProvidesDefaultImplementations() {}
}

///
enum AudioPlayerState {
  unknown,
  play,
  pause,
  stop,
}
