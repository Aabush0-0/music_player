class Urls {
  static final String baseUrl = const String.fromEnvironment(
    'DEEZER_BASE_URL',
    defaultValue: 'https://api.deezer.com/',
  );

  static String searchTracks(String query) => '$baseUrl/search?q=$query';
}
