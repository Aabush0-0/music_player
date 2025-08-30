import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/music_player_provider.dart';

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicPlayerProvider>(context);
    final track = provider.currentTrack;

    return track != null
        ? Text(
            'Now playing: ${track.title}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        : const SizedBox.shrink();
  }
}
