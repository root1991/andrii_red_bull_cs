import 'package:equatable/equatable.dart';

class NetworkRequest extends Equatable {
  final String endpoint;
  final Map<String, String> _queryParameters = {};
  final Map<String, String> _headers = {};
  final NetworkRequestMethod method;
  final dynamic body;

  Map<String, String> get queryParameters => _queryParameters;

  Map<String, String> get headers => _headers;

  NetworkRequest({
    required this.endpoint,
    required this.method,
    this.body,
  });

  void addQueryParameter(String key, String value) {
    queryParameters[key] = value;
  }

  void addHeader(String key, String value) {
    _headers[key] = value;
  }

  @override
  List<Object?> get props => [
        endpoint,
        method,
        body,
      ];
}

enum NetworkRequestMethod {
  get,
  post,
  put,
  patch,
  delete,
}

extension NetworkRequestExtension on NetworkRequest {
  String get methodName {
    switch (method) {
      case NetworkRequestMethod.get:
        return 'GET';
      case NetworkRequestMethod.post:
        return 'POST';
      case NetworkRequestMethod.put:
        return 'PUT';
      case NetworkRequestMethod.patch:
        return 'PATCH';
      case NetworkRequestMethod.delete:
        return 'DELETE';
      default:
        throw Exception('Unknown method: $method');
    }
  }
}