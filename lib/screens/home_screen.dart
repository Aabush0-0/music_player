import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../core/networks/api_urls.dart';
import '../models/track_model.dart';
import '../providers/music_player_provider.dart';
import '../widgets/now_playing_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/track_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  Future<void> searchTracks(BuildContext context, String query) async {
    final provider = Provider.of<MusicPlayerProvider>(context, listen: false);
    provider.setLoading(true);
    provider.setTrackList([]);
    provider.stop();

    try {
      final url = Uri.parse(Urls.searchTracks(query));
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final tracksJson = data['data'] as List;
        final tracks = tracksJson
            .map((json) => Track.fromJson(json))
            .where((t) => t.previewUrl.isNotEmpty)
            .toList();
        provider.setTrackList(tracks);
      } else {
        debugPrint('API error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching tracks: $e');
    }

    provider.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicPlayerProvider>(context);

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
                if (value.isNotEmpty) searchTracks(context, value);
              },
            ),
            const SizedBox(height: 10),
            const NowPlayingWidget(),
            const SizedBox(height: 10),
            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : const Expanded(child: TrackList()),
          ],
        ),
      ),
    );
  }
}
