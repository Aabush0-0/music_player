import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/widgets/album_cover.dart';
import 'package:music_player/widgets/custom_slider.dart';
import 'package:music_player/widgets/playback_controls_widget.dart';
import 'package:music_player/widgets/track_info.dart';

import '../models/track_model.dart';

class NowPlayingScreen extends StatefulWidget {
  final AudioPlayer player;
  final List<Track> trackList;
  final int currentIndex;

  const NowPlayingScreen({
    super.key,
    required this.player,
    required this.trackList,
    required this.currentIndex,
  });

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  late int _currentIndex;
  late Track _currentTrack;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _currentTrack = widget.trackList[_currentIndex];
    _playTrack(_currentTrack);
  }

  Future<void> _playTrack(Track track) async {
    await widget.player.setUrl(track.previewUrl);
    widget.player.play();
    setState(() {
      _currentTrack = track;
    });
  }

  void _onTrackChanged(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
      _currentTrack = widget.trackList[newIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlbumCover(albumCover: _currentTrack.albumCover),
          const SizedBox(height: 20),
          TrackInfoWidget(
            trackTitle: _currentTrack.title,
            artistName: _currentTrack.artistName,
          ),
          const SizedBox(height: 40),
          CustomSlider(player: widget.player),
          const SizedBox(height: 20),
          PlaybackControlsWidget(
            player: widget.player,
            trackList: widget.trackList,
            currentIndex: _currentIndex,
            onTrackChanged: _onTrackChanged,
            onPrevious: () {},
            onNext: () {},
          ),
        ],
      ),
    );
  }
}
