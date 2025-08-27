import 'package:flutter/material.dart';

class NowPlayingWidget extends StatelessWidget {
  final ValueNotifier<String?> currentTrackNotifier;

  const NowPlayingWidget({super.key, required this.currentTrackNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: currentTrackNotifier,
      builder: (context, currentTrack, _) {
        return currentTrack != null
            ? Text(
                'Now playing: $currentTrack',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
