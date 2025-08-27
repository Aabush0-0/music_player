import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PositionData {
  final Duration position;
  final Duration duration;
  PositionData(this.position, this.duration);
}

class CustomSlider extends StatelessWidget {
  final AudioPlayer player;

  const CustomSlider({super.key, required this.player});

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest2<Duration, Duration?, PositionData>(
        player.positionStream,
        player.durationStream,
        (position, duration) =>
            PositionData(position, duration ?? Duration.zero),
      );

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: _positionDataStream,
      builder: (context, snapshot) {
        final positionData =
            snapshot.data ??
            PositionData(Duration.zero, player.duration ?? Duration.zero);

        return Column(
          children: [
            Slider(
              min: 0.0,
              max: positionData.duration.inMilliseconds.toDouble(),
              value: positionData.position.inMilliseconds
                  .clamp(0, positionData.duration.inMilliseconds)
                  .toDouble(),
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              onChanged: (value) {
                player.seek(Duration(milliseconds: value.toInt()));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(positionData.position),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    _formatDuration(positionData.duration),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
