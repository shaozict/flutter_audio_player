// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/cupertino.dart';

import 'method_channel_audio_player.dart';

abstract class AudioPlayerPlatform {
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
        throw AssertionError(
            'Platform interfaces must not be implemented with `implements`');
      }
    }
    _instance = value;
  }

  static AudioPlayerPlatform _instance =
  MethodChannelAudioPlayer();

  /// Only mock implementations should set this to true.
  ///
  /// Mockito mocks are implementing this class with `implements` which is forbidden for anything
  /// other than mocks (see class docs). This property provides a backdoor for mockito mocks to
  /// skip the verification that the class isn't implemented with `implements`.
  @visibleForTesting
  bool get isMock => false;

  Future<void> init()async{}
  //播放
  Future<void> play()async{}
  Future<void> pause()async{}
  Future<void> stop()async{}
  void _verifyProvidesDefaultImplementations() {}
}