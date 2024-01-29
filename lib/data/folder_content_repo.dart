import 'package:red_bull_case_study/blocs/foldercontent/folder_content_state.dart';
import 'package:red_bull_case_study/data/local_data_source.dart';
import 'package:red_bull_case_study/network/network.dart';

class FolderContentRepo {
  final ContentApi _remoteDataSource;
  final LocalDataSource _localDataSource;

  FolderContentRepo(this._remoteDataSource, this._localDataSource);

  Future<List<Item>> loadItemsByFolder(String folder, bool initial) async {
    final localItems = _localDataSource.itemsByFolder(folder);

    if (localItems.isNotEmpty && initial) {
      return localItems;
    }

    final result =
        await _fetchItems(folder, _localDataSource.pageByFolder(folder));
    final videoResult =
        await _fetchVideoItems(folder, _localDataSource.pageByFolder(folder));

    if (result.isSuccess || videoResult.isSuccess) {
      var images = result.data
              ?.map((e) => Item(
                  id: e.id,
                  isPicture: true,
                  name: _getImageFilenameFromUrl(e.previewURL),
                  creationDate: _getCreationDateFromUrl(e.previewURL),
                  thumbnailUrl: e.previewURL))
              .toList() ??
          [];
      var videos = videoResult.data
              ?.map((e) => Item(
                  id: e.id,
                  isPicture: false,
                  name: _getImageFilenameFromUrl(e.medium.url),
                  duration: _formatSecondsToMMSS(e.duration),
                  creationDate: 'N/A',
                  thumbnailUrl:
                      'https://i.vimeocdn.com/video/${e.pictureId}_295x166.jpg'))
              .toList() ??
          [];
      var combinedItems = [...images, ...videos];
      combinedItems.sort((first, second) => first.name.compareTo(second.name));

      _localDataSource.saveCurrentPage(folder);
      _localDataSource.saveCurrentItems(folder, combinedItems);
      return _localDataSource.itemsByFolder(folder);
    } else {
      if (result.error is NetworkConnectionException) {
        throw NetworkConnectionException(null);
      }
      return [];
    }
  }

  Future<Result<List<PixabayImage>, AppNetworkException>> _fetchItems(
    String folder,
    int page,
  ) async {
    return _remoteDataSource.loadImages(folder, page);
  }

  Future<Result<List<PixabayVideo>, AppNetworkException>> _fetchVideoItems(
    String folder,
    int page,
  ) async {
    return _remoteDataSource.loadVideos(folder, page);
  }

  String _getImageFilenameFromUrl(String url) {
    var uri = Uri.parse(url);
    var filename = uri.pathSegments.last;
    return filename;
  }

  String _getCreationDateFromUrl(String url) {
    try {
      final regex = RegExp(r'/(\d{4})/(\d{2})/(\d{2})/');
      final match = regex.firstMatch(url);

      if (match != null && match.groupCount == 3) {
        final year = match.group(1);
        final month = match.group(2);
        final day = match.group(3);

        return '$day/$month/$year';
      }
    } catch (e) {
      // In case of parse error error
    }
    return 'N/A';
  }

  String _formatSecondsToMMSS(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return "$formattedMinutes:$formattedSeconds";
  }
}
