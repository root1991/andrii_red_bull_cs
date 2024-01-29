class PixabayVideoDetail {
  final String url;
  final int width;
  final int height;
  final int size;

  PixabayVideoDetail({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
  });

  factory PixabayVideoDetail.fromJson(Map<String, dynamic> json) {
    return PixabayVideoDetail(
      url: json['url'],
      width: json['width'],
      height: json['height'],
      size: json['size'],
    );
  }
}
