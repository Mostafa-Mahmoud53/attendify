import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warn, error }

class AppLogger {
  AppLogger({this.enabled = true});

  final bool enabled;

  void debug(String message) => _log(LogLevel.debug, message);
  void info(String message) => _log(LogLevel.info, message);
  void warn(String message) => _log(LogLevel.warn, message);
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  void _log(LogLevel level, String message, [Object? error, StackTrace? stackTrace]) {
    if (!enabled) {
      return;
    }

    final prefix = _prefix(level);
    final buffer = StringBuffer('$prefix $message');
    if (error != null) {
      buffer.write(' | error=$error');
    }

    debugPrint(buffer.toString());
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }

  String _prefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '[DEBUG]';
      case LogLevel.info:
        return '[INFO]';
      case LogLevel.warn:
        return '[WARN]';
      case LogLevel.error:
        return '[ERROR]';
    }
  }
}
