abstract class Failure {
  const Failure(this.message, {this.code});

  final String message;
  final String? code;
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message, {String? code}) : super(message, code: code);
}

class CacheFailure extends Failure {
  const CacheFailure(String message, {String? code}) : super(message, code: code);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message, {String? code}) : super(message, code: code);
}
