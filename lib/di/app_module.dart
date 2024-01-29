import 'package:dio/dio.dart';
import 'package:red_bull_case_study/data/folder_content_repo.dart';
import 'package:red_bull_case_study/data/local_data_source.dart';
import 'package:red_bull_case_study/network/app_api.dart';
import 'package:red_bull_case_study/network/app_urls.dart';
import 'package:red_bull_case_study/network/content_api.dart';
import 'package:red_bull_case_study/network/network_error_handler.dart';

class AppModule {
  late final AppUrls _appUrls;
  late final AppApi _appApi;
  late final ContentApi _contentApi;
  late final NetworkErrorHandler _networkErrorHandler;
  late final FolderContentRepo folderContentRepo;

  Future<void> initDependencies() async {
    _appUrls = AppUrls();
    _networkErrorHandler = NetworkErrorHandler();
    _appApi = AppApi(Dio(), _networkErrorHandler);
    _contentApi = ContentApi(_appUrls, _appApi);
    folderContentRepo = FolderContentRepo(_contentApi, LocalDataSource());
  }
}
