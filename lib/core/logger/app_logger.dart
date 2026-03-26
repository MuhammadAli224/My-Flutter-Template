import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// A singleton logger class for the entire app.
///
/// - On **mobile/desktop**: uses the `logger` package (colored, structured output).
/// - On **web**: falls back to `print()` because the logger ANSI colors
///   break Flutter Web's browser console.
///
/// Usage:
///   AppLogger.t('Trace message');
///   AppLogger.d('Debug message');
///   AppLogger.i('Info message');
///   AppLogger.w('Warning message');
///   AppLogger.e('Error message', error: e, stackTrace: s);
///   AppLogger.f('Fatal message');
class AppLogger {
  // ─── Private Constructor ──────────────────────────────────────────────────

  AppLogger._();

  // ─── Logger Instance (mobile/desktop only) ────────────────────────────────

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: _resolveLogLevel(),
  );

  static Level _resolveLogLevel() {
    // ignore: do_not_use_environment
    const bool isRelease = bool.fromEnvironment('dart.vm.product');
    return isRelease ? Level.warning : Level.trace;
  }

  // ─── Web print helper ─────────────────────────────────────────────────────

  static void _webPrint(
      String label,
      dynamic message, {
        Object? error,
        StackTrace? stackTrace,
      }) {
    // ignore: avoid_print
    print('[$label] $message${error != null ? ' | ERROR: $error' : ''}${stackTrace != null ? '\n$stackTrace' : ''}');
  }

  // ─── Static Logging Methods ───────────────────────────────────────────────

  /// Log a **trace** message (most verbose – useful for step-by-step tracing).
  static void t(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (kIsWeb) {
      _webPrint('TRACE', message, error: error, stackTrace: stackTrace);
    } else {
      _logger.t(message, time: time, error: error, stackTrace: stackTrace);
    }
  }

  /// Log a **debug** message (general development information).
  static void d(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (kIsWeb) {
      _webPrint('DEBUG', message, error: error, stackTrace: stackTrace);
    } else {
      _logger.d(message, time: time, error: error, stackTrace: stackTrace);
    }
  }

  /// Log an **info** message (notable but expected events).
  static void i(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (kIsWeb) {
      _webPrint('INFO', message, error: error, stackTrace: stackTrace);
    } else {
      _logger.i(message, time: time, error: error, stackTrace: stackTrace);
    }
  }

  /// Log a **warning** message (unexpected but non-critical situations).
  static void w(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (kIsWeb) {
      _webPrint('WARNING', message, error: error, stackTrace: stackTrace);
    } else {
      _logger.w(message, time: time, error: error, stackTrace: stackTrace);
    }
  }

  /// Log an **error** message (failures that affect functionality).
  static void e(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (kIsWeb) {
      _webPrint('ERROR', message, error: error, stackTrace: stackTrace);
    } else {
      _logger.e(message, time: time, error: error, stackTrace: stackTrace);
    }
  }

  /// Log a **fatal** message (critical failures / crashes).
  static void f(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (kIsWeb) {
      _webPrint('FATAL', message, error: error, stackTrace: stackTrace);
    } else {
      _logger.f(message, time: time, error: error, stackTrace: stackTrace);
    }
  }
}