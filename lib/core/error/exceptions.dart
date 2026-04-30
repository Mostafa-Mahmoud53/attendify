class AppException implements Exception {
  AppException(this.message, {this.code});

  final String message;
  final String? code;
}

class NetworkException extends AppException {
  NetworkException(String message, {String? code}) : super(message, code: code);
}

class CacheException extends AppException {
  CacheException(String message, {String? code}) : super(message, code: code);
}
