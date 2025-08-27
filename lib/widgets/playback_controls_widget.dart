import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/track_model.dart';

class PlaybackControlsWidget extends StatefulWidget {
  final AudioPlayer player;
  final List<Track> trackList;
  final int currentIndex;
  final Function(int newIndex) onTrackChanged;

  const PlaybackControlsWidget({
    super.key,
    required this.player,
    required this.trackList,
    required this.currentIndex,
    required this.onTrackChanged,
    required Null Function() onPrevious,
    required Null Function() onNext,
  });

  @override
  State<PlaybackControlsWidget> createState() => _PlaybackControlsWidgetState();
}

class _PlaybackControlsWidgetState extends State<PlaybackControlsWidget> {
  late int _currentIndex;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    isPlaying = widget.player.playing;

    widget.player.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });
  }

  Future<void> _playTrack(int index) async {
    final track = widget.trackList[index];
    await widget.player.setUrl(track.previewUrl);
    widget.player.play();
    setState(() {
      _currentIndex = index;
    });
    widget.onTrackChanged(index);
  }

  void _nextTrack() {
    if (_currentIndex < widget.trackList.length - 1) {
      _playTrack(_currentIndex + 1);
    }
  }

  void _previousTrack() {
    if (_currentIndex > 0) {
      _playTrack(_currentIndex - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 48,
          color: Colors.white,
          icon: const Icon(Icons.skip_previous),
          onPressed: _previousTrack,
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 64,
          color: Colors.white,
          icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
          onPressed: () {
            if (isPlaying) {
              widget.player.pause();
            } else {
              widget.player.play();
            }
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 48,
          color: Colors.white,
          icon: const Icon(Icons.skip_next),
          onPressed: _nextTrack,
        ),
      ],
    );
  }
}
