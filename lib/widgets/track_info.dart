import 'package:flutter/material.dart';

class TrackInfoWidget extends StatelessWidget {
  final String trackTitle;
  final String artistName;

  const TrackInfoWidget({
    super.key,
    required this.trackTitle,
    required this.artistName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          trackTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          artistName,
          style: const TextStyle(color: Colors.grey, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
