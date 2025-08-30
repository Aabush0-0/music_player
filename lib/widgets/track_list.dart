import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/music_player_provider.dart';
import '../screens/now_playing_screen.dart';

class TrackList extends StatelessWidget {
  const TrackList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicPlayerProvider>(context);
    final tracks = provider.trackList;

    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        return ListTile(
          tileColor: Colors.grey[900],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Image.network(
            track.albumCover,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(track.title, style: const TextStyle(color: Colors.white)),
          subtitle: Text(
            track.artistName,
            style: TextStyle(color: Colors.grey[400]),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            onPressed: () {
              provider.playTrack(track);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NowPlayingScreen()),
              );
            },
          ),
        );
      },
    );
  }
}
