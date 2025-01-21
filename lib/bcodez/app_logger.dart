

import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._privateConstructor();

  static final AppLogger instance = AppLogger._privateConstructor();
  static Logger? _logger;

  Logger get logger => _logger ??= Logger();

  debug(d) {
    logger.d(d);
  }

  error(e) {
    logger.e(e);
  }
}