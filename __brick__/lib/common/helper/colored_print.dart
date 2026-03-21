import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Utility for colored console printing in Dart / Flutter (debug only)
/// Works in terminal / console (not for UI)

const _black = '\x1B[30m';
const _red = '\x1B[31m';
const _green = '\x1B[32m';
const _blue = '\x1B[34m';
const _magenta = '\x1B[35m';
const _cyan = '\x1B[36m';
const _white = '\x1B[37m';
const _gray = '\x1B[90m';
const _brightRed = '\x1B[91m';
const _brightGreen = '\x1B[92m';
const _brightBlue = '\x1B[94m';
const _brightMagenta = '\x1B[95m';
const _brightCyan = '\x1B[96m';
const _brightWhite = '\x1B[97m';

/// Orange (24-bit RGB; supported by most modern terminals)
const _orange = '\x1B[38;2;255;165;0m';
const _reset = '\x1B[0m';

/// Print in RED
void printR(Object? message) {
  if (kDebugMode) {
    print('$_red$message$_reset');
  }
}

/// Print in GREEN
void printG(Object? message) {
  if (kDebugMode) {
    print('$_green$message$_reset');
  }
}

/// Print in BLUE
void printB(Object? message) {
  if (kDebugMode) {
    print('$_blue$message$_reset');
  }
}

/// Print in MAGENTA
void printM(Object? message) {
  if (kDebugMode) {
    print('$_magenta$message$_reset');
  }
}

/// Print in CYAN
void printC(Object? message) {
  if (kDebugMode) {
    print('$_cyan$message$_reset');
  }
}

/// Print in BLACK
void printK(Object? message) {
  if (kDebugMode) {
    print('$_black$message$_reset');
  }
}

/// Print in WHITE
void printW(Object? message) {
  if (kDebugMode) {
    print('$_white$message$_reset');
  }
}

/// Print in GRAY (bright black)
void printGr(Object? message) {
  if (kDebugMode) {
    print('$_gray$message$_reset');
  }
}

/// Print in BRIGHT RED
void printBR(Object? message) {
  if (kDebugMode) {
    print('$_brightRed$message$_reset');
  }
}

/// Print in BRIGHT GREEN
void printBG(Object? message) {
  if (kDebugMode) {
    print('$_brightGreen$message$_reset');
  }
}

/// Print in BRIGHT BLUE
void printBB(Object? message) {
  if (kDebugMode) {
    print('$_brightBlue$message$_reset');
  }
}

/// Print in BRIGHT MAGENTA
void printBM(Object? message) {
  if (kDebugMode) {
    print('$_brightMagenta$message$_reset');
  }
}

/// Print in BRIGHT CYAN
void printBC(Object? message) {
  if (kDebugMode) {
    print('$_brightCyan$message$_reset');
  }
}

/// Print in BRIGHT WHITE
void printBW(Object? message) {
  if (kDebugMode) {
    print('$_brightWhite$message$_reset');
  }
}

/// Print in ORANGE
void printO(Object? message) {
  if (kDebugMode) {
    print('$_orange$message$_reset');
  }
}

/// Print normally
void printN(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}

class LogColors {
  static const reset = '\x1B[0m';
  static const black = '\x1B[30m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';
  static const white = '\x1B[37m';
  static const gray = '\x1B[90m';
  static const brightRed = '\x1B[91m';
  static const brightGreen = '\x1B[92m';
  static const brightBlue = '\x1B[94m';
  static const brightMagenta = '\x1B[95m';
  static const brightCyan = '\x1B[96m';
  static const brightWhite = '\x1B[97m';

  /// Orange (24-bit RGB)
  static const orange = '\x1B[38;2;255;165;0m';
}

void initLogger() {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    String color;

    switch (record.level) {
      case Level.SEVERE:
        color = LogColors.red;
        break;
      case Level.WARNING:
        color = LogColors.orange;
        break;
      case Level.INFO:
        color = LogColors.brightBlue;
        break;
      case Level.CONFIG:
        color = LogColors.green;
        break;
      default:
        color = LogColors.cyan;
    }

    debugPrint(
      '$color${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}${LogColors.reset}',
    );
  });
}
