import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/track_model.dart';

class MusicPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  List<Track> _trackList = [];
  Track? _currentTrack;
  bool _isLoading = false;

  List<Track> get trackList => _trackList;
  Track? get currentTrack => _currentTrack;
  bool get isLoading => _isLoading;
  AudioPlayer get player => _player;

  MusicPlayerProvider() {
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        nextTrack();
      }
    });
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setTrackList(List<Track> tracks) {
    _trackList = tracks;
    notifyListeners();
  }

  Future<void> playTrack(Track track) async {
    if (track.previewUrl.isEmpty) {
      debugPrint('No preview available for this track: ${track.title}');
      return;
    }

    try {
      if (_currentTrack != track) {
        _currentTrack = track;
        await _player.setUrl(track.previewUrl);
      }
      _player.play();
      notifyListeners();
    } catch (e) {
      debugPrint('Error playing track: $e');
    }
  }

  void resume() {
    if (_currentTrack != null) {
      _player.play();
      notifyListeners();
    }
  }

  void pause() {
    _player.pause();
    notifyListeners();
  }

  void stop() {
    _player.stop();
    _currentTrack = null;
    notifyListeners();
  }

  void nextTrack() {
    if (_currentTrack == null || _trackList.isEmpty) return;
    final index = _trackList.indexOf(_currentTrack!);
    if (index < _trackList.length - 1) {
      playTrack(_trackList[index + 1]);
    } else {
      stop();
    }
  }

  void previousTrack() {
    if (_currentTrack == null || _trackList.isEmpty) return;
    final index = _trackList.indexOf(_currentTrack!);
    if (index > 0) {
      playTrack(_trackList[index - 1]);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
