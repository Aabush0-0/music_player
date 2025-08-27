import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:music_player/core/networks/api_urls.dart';

import '../models/track_model.dart';
import '../widgets/now_playing_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/track_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _player = AudioPlayer();

  final ValueNotifier<List<Track>> trackListNotifier = ValueNotifier([]);
  final ValueNotifier<String?> currentTrackNotifier = ValueNotifier(null);
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  Future<void> searchTracks(String query) async {
    isLoadingNotifier.value = true;
    trackListNotifier.value = [];
    currentTrackNotifier.value = null;

    final url = Uri.parse(Urls.searchTracks(query));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tracksJson = data['data'] as List;
      final tracks = tracksJson.map((json) => Track.fromJson(json)).toList();
      trackListNotifier.value = tracks;
    }

    isLoadingNotifier.value = false;
  }

  Future<void> playPreview(String url, String title) async {
    currentTrackNotifier.value = title;
    await _player.setUrl(url);
    _player.play();
  }

  @override
  void dispose() {
    _player.dispose();
    _controller.dispose();
    trackListNotifier.dispose();
    currentTrackNotifier.dispose();
    isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Songs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBarWidget(
              controller: _controller,
              onSubmitted: (value) {
                if (value.isNotEmpty) searchTracks(value);
              },
            ),
            const SizedBox(height: 10),
            NowPlayingWidget(currentTrackNotifier: currentTrackNotifier),
            const SizedBox(height: 10),
            Expanded(
              child: TrackList(
                trackListNotifier: trackListNotifier,
                onTrackTap: playPreview,
                player: _player,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
