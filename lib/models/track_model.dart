class Track {
  final String title;
  final String artistName;
  final String albumCover;
  final String previewUrl;

  Track({
    required this.title,
    required this.artistName,
    required this.albumCover,
    required this.previewUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      title: json['title'] ?? '',
      artistName: json['artist']['name'] ?? '',
      albumCover: json['album']['cover_small'] ?? '',
      previewUrl: json['preview'] ?? '',
    );
  }
}
