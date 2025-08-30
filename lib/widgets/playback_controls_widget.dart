import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/music_player_provider.dart';

class PlaybackControlsWidget extends StatelessWidget {
  const PlaybackControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicPlayerProvider>(context);
    final player = provider.player;
    final track = provider.currentTrack;

    if (track == null) return const SizedBox.shrink();

    final isPlaying = player.playing;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 48,
          color: Colors.white,
          icon: const Icon(Icons.skip_previous),
          onPressed: provider.previousTrack,
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 64,
          color: Colors.white,
          icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
          onPressed: () {
            if (isPlaying) {
              provider.pause();
            } else {
              provider.playTrack(track);
            }
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 48,
          color: Colors.white,
          icon: const Icon(Icons.skip_next),
          onPressed: provider.nextTrack,
        ),
      ],
    );
  }
}
