import 'package:flutter/foundation.dart';

/// Utility for colored console printing in Dart / Flutter (debug only)
/// Works in terminal / console (not for UI)

const _red = '\x1B[31m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _blue = '\x1B[34m';
const _magenta = '\x1B[35m';
const _cyan = '\x1B[36m';
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

/// Print in YELLOW
void printY(Object? message) {
  if (kDebugMode) {
    print('$_yellow$message$_reset');
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

/// Print normally
void printN(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}
