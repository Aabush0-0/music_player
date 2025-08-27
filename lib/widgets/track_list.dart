import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/track_model.dart';
import '../screens/now_playing_screen.dart';

class TrackList extends StatelessWidget {
  final ValueNotifier<List<Track>> trackListNotifier;
  final Function(String url, String title) onTrackTap;
  final AudioPlayer player;

  const TrackList({
    super.key,
    required this.trackListNotifier,
    required this.onTrackTap,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Track>>(
      valueListenable: trackListNotifier,
      builder: (context, trackList, _) {
        return ListView.builder(
          itemCount: trackList.length,
          itemBuilder: (context, index) {
            final track = trackList[index];
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
              title: Text(
                track.title,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                track.artistName,
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                onPressed: () async {
                  await onTrackTap(track.previewUrl, track.title);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NowPlayingScreen(
                        player: player,
                        trackList: trackList,
                        currentIndex: index,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
