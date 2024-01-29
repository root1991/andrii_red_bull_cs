import 'package:dio/dio.dart';
import 'package:red_bull_case_study/network/app_network_exception.dart';
import 'package:red_bull_case_study/network/network_error_handler.dart';
import 'package:red_bull_case_study/network/network_request.dart';
import 'package:red_bull_case_study/network/result.dart';

class AppApi {
  final Dio _apiClient;
  final NetworkErrorHandler _networkErrorHandler;

  AppApi(
    this._apiClient,
    this._networkErrorHandler,
  );

  Future<Result<T, AppNetworkException>> execute<T>(
      NetworkRequest request) async {

    final requestOptions = RequestOptions(
      path: request.endpoint,
      method: request.methodName,
      data: request.body,
      queryParameters: request.queryParameters,
    );

    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    Result<T, AppNetworkException> apiResponse;

    try {
      final rawResponse = await _apiClient.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );

      apiResponse = Success(rawResponse.data as T);
      if (rawResponse.statusCode == null) {
        return apiResponse;
      }
    } on Exception catch (e) {
      final appError = _networkErrorHandler.handleError(e, fatal: true);
      apiResponse = Failure(appError ?? UnknownNetworkException(null));
    }

    return apiResponse;
  }
}