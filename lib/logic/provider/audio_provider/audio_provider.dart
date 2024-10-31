// ignore_for_file: non_constant_identifier_names, avoid_return_types_on_setters

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musix_desktop/data/model/song_model.dart';

class AudioProvider extends ChangeNotifier {
  final _audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Duration _bufferedPosition = Duration.zero; // Track buffered position
  String _msg = '';
  double sliderValue = 0.0;

  String title = '';
  String artist = '';
  String hexcode = '';
  String thumnail_url = '';

  StreamSubscription<Duration?>? _durStream;
  StreamSubscription<Duration>? _posStream;
  StreamSubscription<Duration>? _bufStream;
  StreamSubscription<PlayerState>? _stateStream;

// // Getter and Setter for title
//   String get title => _title;
//   set title(String value) {
//     if (_title != value) {
//       _title = value;
//       notifyListeners();
//     }
//   }
//   get artist => _artist;
//   get hexcode => _hexcode;
//   get thumnail_url => _thumnail_url;

  AudioPlayer get audioPlayer => _audioPlayer;
  Duration get duration => _duration;
  Duration get position => _position;
  Duration get bufferedPosition =>
      _bufferedPosition; // Expose buffered position
  String get msg => _msg;

  bool get isPlaying => _audioPlayer.playing;
  bool get isBuffering =>
      _audioPlayer.processingState == ProcessingState.buffering;
  bool get isCompleted =>
      _audioPlayer.processingState == ProcessingState.completed;

  // Expose the player state stream to the UI
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

//set the source url
  // void setUrl(SongModel song) async {
  //   try {
  //     await _audioPlayer.setUrl(song.song_url);
  //     _setupListeners();
  //     await play(); // Ensure play is awaited to handle immediate playback
  //   } catch (e) {
  //     _msg = e.toString();
  //     notifyListeners();
  //   }
  // }

  void setSource(SongModel song) async {
    title = song.title;
    artist = song.artist;
    hexcode = song.hex_code;
    thumnail_url = song.thumbnail_url;
    try {
      final audioSource = AudioSource.uri(Uri.parse(song.song_url),
          tag: MediaItem(
              id: song.id,
              title: song.title,
              artist: song.artist,
              artUri: Uri.parse(song.thumbnail_url)));
      await _audioPlayer.setAudioSource(audioSource);
      _setupListeners();
      await play();
    } catch (e) {
      _msg = e.toString();
      notifyListeners();
    }
  }

  Future<void> play() async {
    try {
      _audioPlayer.play();
      notifyListeners();
    } catch (e) {
      _msg = e.toString();
      notifyListeners();
    }
  }

  Future<void> pause() async {
    try {
      _audioPlayer.pause();
      notifyListeners();
    } catch (e) {
      _msg = e.toString();
      notifyListeners();
    }
  }

  void playPause() {
    if (isPlaying) {
      pause();
    } else {
      play();
    }
  }

  Future<void> playAgain(String url) async {
    try {
      _audioPlayer.setUrl(url);
      notifyListeners();
    } catch (e) {
      _msg = e.toString();
      notifyListeners();
    }
  }

  void seek(double value) {
    _audioPlayer.seek(Duration(seconds: value.toInt()));
    notifyListeners();
  }

  void sliderChange(double val) {
    sliderValue = val;
    notifyListeners();
  }

  void _setupListeners() {
    _durStream?.cancel();
    _posStream?.cancel();
    _stateStream?.cancel();

    _durStream = _audioPlayer.durationStream.listen((d) {
      if (d != _duration) {
        _duration = d ?? Duration.zero;
        notifyListeners();
      }
    });

    _posStream = _audioPlayer.positionStream.listen((p) {
      if (p != _position) {
        _position = p;
        notifyListeners();
      }
    });
    _bufStream = _audioPlayer.bufferedPositionStream.listen((b) {
      if (b != _bufferedPosition) {
        _bufferedPosition = b;
        notifyListeners();
      }
    });

    _stateStream = _audioPlayer.playerStateStream.listen((state) {
      // Optionally handle player state changes
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _durStream?.cancel();
    _posStream?.cancel();
    _bufStream?.cancel();
    _stateStream?.cancel();
    super.dispose();
  }
}
