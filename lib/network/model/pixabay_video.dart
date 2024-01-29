import 'package:red_bull_case_study/network/model/pixalbay_video_details.dart';

class PixabayVideo {
  final int id;
  final String pageURL;
  final String type;
  final String tags;
  final int duration;
  final String pictureId;
  final PixabayVideoDetail large;
  final PixabayVideoDetail medium;
  final PixabayVideoDetail small;
  final PixabayVideoDetail tiny;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageURL;

  PixabayVideo({
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.duration,
    required this.pictureId,
    required this.large,
    required this.medium,
    required this.small,
    required this.tiny,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageURL,
  });

  factory PixabayVideo.fromJson(Map<String, dynamic> json) {
    return PixabayVideo(
      id: json['id'],
      pageURL: json['pageURL'],
      type: json['type'],
      tags: json['tags'],
      duration: json['duration'],
      pictureId: json['picture_id'],
      large: PixabayVideoDetail.fromJson(json['videos']['large']),
      medium: PixabayVideoDetail.fromJson(json['videos']['medium']),
      small: PixabayVideoDetail.fromJson(json['videos']['small']),
      tiny: PixabayVideoDetail.fromJson(json['videos']['tiny']),
      views: json['views'],
      downloads: json['downloads'],
      likes: json['likes'],
      comments: json['comments'],
      userId: json['user_id'],
      user: json['user'],
      userImageURL: json['userImageURL'],
    );
  }
}
