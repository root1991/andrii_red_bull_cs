import 'package:dio/dio.dart';

import 'app_network_exception.dart';

class NetworkErrorHandler {
  AppNetworkException? handleError(error, {bool? fatal}) {
    final transformed = _transformException(error);
    return transformed;
  }
}

AppNetworkException? _transformException(Exception e) {
  if (e is AppNetworkException) {
    return e;
  }
  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.receiveTimeout:
        return NetworkConnectionException(e.response);

      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
      case DioExceptionType.badResponse:
      case DioExceptionType.badCertificate:
        return UnknownNetworkException(e.response);
    }
  } else {
    return null;
  }
}
