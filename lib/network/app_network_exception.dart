import 'package:dio/dio.dart';

abstract class AppNetworkException implements Exception {
  AppNetworkException(this.response);

  final Response? response;
}

class UnknownNetworkException extends AppNetworkException {
  UnknownNetworkException(Response? response) : super(response);
}

class NetworkConnectionException extends AppNetworkException {
  NetworkConnectionException(Response? response) : super(response);
}

extension AppNetworkExceptionMessage on AppNetworkException {
  String get message {
    switch (runtimeType) {
      case UnknownNetworkException:
        return "Smth went wrong";
      case NetworkConnectionException:
        return "Smth went wrong";
      default:
        return"Smth went wrong";
    }
  }
}