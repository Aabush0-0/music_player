import 'package:flutter/material.dart';

class AlbumCover extends StatelessWidget {
  final String albumCover;

  const AlbumCover({super.key, required this.albumCover});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          albumCover,
          width: 300,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
