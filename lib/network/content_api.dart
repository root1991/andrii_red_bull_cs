import 'package:red_bull_case_study/network/app_api.dart';
import 'package:red_bull_case_study/network/app_network_exception.dart';
import 'package:red_bull_case_study/network/app_urls.dart';
import 'package:red_bull_case_study/network/model/pixabay_image.dart';
import 'package:red_bull_case_study/network/model/pixabay_video.dart';
import 'package:red_bull_case_study/network/network_request.dart';
import 'package:red_bull_case_study/network/result.dart';

class ContentApi {
  final AppApi _api;
  final AppUrls _appUrls;

  ContentApi(this._appUrls, this._api);

  Future<Result<List<PixabayImage>, AppNetworkException>> loadImages(
    String folder,
    int page,
  ) async {
    final request = NetworkRequest(
      endpoint: _appUrls.images(folder, page),
      method: NetworkRequestMethod.get,
    );

    final response = await _api.execute(request);

    return response.when(
      (data) async {
        if (data['hits'] is List && (data['hits'] as List).isNotEmpty) {
          var images = (data['hits'] as List)
              .map((e) => PixabayImage.fromJson(e))
              .toList();
          return Success(images);
        } else {
          return Failure(UnknownNetworkException(null));
        }
      },
      (error) => Failure(error),
    );
  }

  Future<Result<List<PixabayVideo>, AppNetworkException>> loadVideos(
    String folder,
    int page,
  ) async {
    final request = NetworkRequest(
      endpoint: _appUrls.videos(folder, page), 
      method: NetworkRequestMethod.get,
    );

    final response = await _api.execute(request);

    return response.when(
      (data) async {
        if (data['hits'] is List && (data['hits'] as List).isNotEmpty) {
          var videos = (data['hits'] as List)
              .map((e) => PixabayVideo.fromJson(e))
              .toList();
          return Success(videos);
        } else {
          return Failure(UnknownNetworkException(null));
        }
      },
      (error) => Failure(error),
    );
  }
}
