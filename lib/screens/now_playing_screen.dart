import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/music_player_provider.dart';
import '../widgets/album_cover.dart';
import '../widgets/custom_slider.dart';
import '../widgets/playback_controls_widget.dart';
import '../widgets/track_info.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicPlayerProvider>(context);
    final track = provider.currentTrack;

    if (track == null) return const SizedBox.shrink();

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
          AlbumCover(albumCover: track.albumCover),
          const SizedBox(height: 20),
          TrackInfoWidget(
            trackTitle: track.title,
            artistName: track.artistName,
          ),
          const SizedBox(height: 40),
          CustomSlider(player: provider.player),
          const SizedBox(height: 20),
          const PlaybackControlsWidget(),
        ],
      ),
    );
  }
}
