class AppUrls {
  String get baseUrl => 'https://pixabay.com/api/';

  String images(String folder, int page) =>
      '$baseUrl/?key=42048103-a49a4460bd16d36a6972e8288&q=$folder&page=$page&per_page=25';

  String videos(String folder, int page) =>
      '$baseUrl/videos?key=42048103-a49a4460bd16d36a6972e8288&q=$folder&page=$page&per_page=25';
}
