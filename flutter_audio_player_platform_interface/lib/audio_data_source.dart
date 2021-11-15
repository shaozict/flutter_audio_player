enum AudioDataSourceType {
  network,
  liveStream,
  file,
  asset,
}
abstract class AudioSource {
  AudioSourceType get audioSourceType;
}
enum AudioSourceType{
  audio,
  playlist,
}


class AudioDataSource  implements AudioSource{
  final String path;
  final String? package;
  final AudioDataSourceType audioDataSourceType;
  // Metas _metas;
  // final Map<String, String>? _networkHeaders;
  final bool? cached; // download audio then play it
  final double? playSpeed;
  final double? pitch;
  final Duration? duration;

  AudioDataSource.asset(
      this.path, {
        this.playSpeed,
        this.package,
        this.pitch,
        this.duration,
      })  : audioDataSourceType = AudioDataSourceType.asset,
  // _networkHeaders = null,
        cached = false;

  AudioDataSource.file(
      this.path, {
        this.playSpeed,
        this.pitch,this.duration,
      })  : audioDataSourceType = AudioDataSourceType.file,
        package = null,
  // _networkHeaders = null,
        cached = false;

  AudioDataSource.network(
      this.path, {
        Map<String, String>? headers,
        this.cached = false,
        this.playSpeed,
        this.duration,
        this.pitch,
      })  : audioDataSourceType = AudioDataSourceType.network,
        package = null
  // _networkHeaders = headers
      ;

  AudioDataSource.liveStream(
      this.path, {
        this.playSpeed,
        this.pitch,
        Map<String, String>? headers,
        this.duration,
      })  : audioDataSourceType = AudioDataSourceType.liveStream,
        package = null,
  // _networkHeaders = headers,
        cached = false;

  @override
  String toString() {
    return 'AudioDataSource{path: $path, package: $package, audioDataSourceType: $audioDataSourceType, cached: $cached, playSpeed: $playSpeed, pitch: $pitch}';
  }

  @override
  AudioSourceType get audioSourceType => AudioSourceType.audio;
}

class AudioPlaylist implements AudioSource{
  final List<AudioDataSource> playList;

  AudioPlaylist(this.playList);

  @override
  AudioSourceType get audioSourceType => AudioSourceType.playlist;
}
