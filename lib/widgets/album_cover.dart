import 'package:flutter/material.dart';

class AlbumCover extends StatelessWidget {
  final String albumCover;

  const AlbumCover({super.key, required this.albumCover});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      albumCover,
      width: 250,
      height: 250,
      fit: BoxFit.cover,
    );
  }
}
