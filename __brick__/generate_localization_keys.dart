// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'figma_to_arb.dart';

void main() {
  const arFilePath = 'assets/l10n/ar.json';
  const enFilePath = 'assets/l10n/en.json';
  const keysFilePath = 'lib/common/translate/app_string.dart';

  // ---------- Load ar.json (DOMINANT) ----------
  final arFile = File(arFilePath);
  if (!arFile.existsSync()) {
    print('❌ Error: ar.json not found.');
    return;
  }
  final Map<String, dynamic> arMapOriginal = jsonDecode(
    arFile.readAsStringSync(),
  );

  // ---------- Fix empty keys in ar.json ----------
  String cleanTextToKey(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '');
    final words =
        cleaned.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

    if (words.isEmpty) {
      return 'emptyKey';
    }

    final first = words.first.toLowerCase();
    final rest = words
        .skip(1)
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join();

    return first + rest;
  }

  void fixEmptyKeys(Map<String, dynamic> map) {
    final keysToAdd = <String, dynamic>{};
    final keysToRemove = <String>[];
    map.forEach((key, value) {
      if (key == "") {
        final newKey = cleanTextToKey(value.toString());
        keysToAdd[newKey] = value;
        keysToRemove.add(key);
        print('🔑 Empty key replaced with: $newKey');
      } else if (value is Map<String, dynamic>) {
        fixEmptyKeys(value);
      }
    });
    for (final k in keysToRemove) {
      map.remove(k);
    }
    map.addAll(keysToAdd);
  }

  fixEmptyKeys(arMapOriginal);

  // ---------- Remove duplicate values in ar.json ----------
  final Map<String, dynamic> arMap = {};
  final Set<String> seenValues = {};

  void removeDuplicates(
    Map<String, dynamic> source,
    Map<String, dynamic> target,
  ) {
    source.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        target[key] = {};
        removeDuplicates(value, target[key]);
      } else {
        if (!seenValues.contains(value.toString())) {
          target[key] = value;
          seenValues.add(value.toString());
        } else {
          print("❌ Duplicate value removed from ar.json: key=$key");
        }
      }
    });
  }

  removeDuplicates(arMapOriginal, arMap);

  arFile.writeAsStringSync(const JsonEncoder.withIndent('    ').convert(arMap));
  print("✅ ar.json cleaned (dominant file).");

  // ---------- Load en.json ----------
  final enFile = File(enFilePath);
  if (!enFile.existsSync()) {
    print('❌ Error: en.json not found.');
    return;
  }
  final Map<String, dynamic> enMap = jsonDecode(enFile.readAsStringSync());

  // ---------- Remove keys from en.json that do NOT exist in ar.json ----------
  bool removed = false;

  void removeExtraKeys(Map<String, dynamic> en, Map<String, dynamic> ar) {
    final keysToRemove = <String>[];
    en.forEach((key, value) {
      if (!ar.containsKey(key)) {
        keysToRemove.add(key);
      } else if (value is Map<String, dynamic> &&
          ar[key] is Map<String, dynamic>) {
        removeExtraKeys(value, ar[key]);
      }
    });
    for (final key in keysToRemove) {
      en.remove(key);
      removed = true;
      print("🗑 Removed extra key from en.json: $key");
    }
  }

  removeExtraKeys(enMap, arMap);

  // ---------- Sync missing keys from ar → en ----------
  bool updated = false;

  void syncMissing(Map<String, dynamic> ar, Map<String, dynamic> en) {
    ar.forEach((key, value) {
      if (!en.containsKey(key)) {
        en[key] = ""; // English translator fills later
        print("➕ Added missing key to en.json: $key");
        updated = true;
      } else if (value is Map<String, dynamic>) {
        if (en[key] is! Map) {
          en[key] = {};
        }
        syncMissing(value, en[key]);
      }
    });
  }

  syncMissing(arMap, enMap);

  if (updated || removed) {
    enFile
        .writeAsStringSync(const JsonEncoder.withIndent('    ').convert(enMap));
    print("✅ en.json synced with ar.json.");
  }

  // ---------- Generate Dart keys from ARABIC ----------
  final keysBuffer = StringBuffer();

  keysBuffer.writeln('''
import 'package:easy_localization/easy_localization.dart';

class AppString {''');

  void generateKeys(Map<String, dynamic> map, [String prefix = '']) {
    for (final entry in map.entries) {
      final key = entry.key;
      final value = entry.value.toString().replaceAll('\n', '');
      final newKey = key.contains('_') ? toCamelCase(key) : key;
      final fullKey = prefix.isNotEmpty ? '$prefix.$key' : key;

      if (entry.value is Map) {
        generateKeys(entry.value, fullKey);
      } else {
        keysBuffer.writeln();
        keysBuffer.writeln("  /// $value");
        keysBuffer.writeln(
          "  static String get $newKey => '$fullKey'.tr();",
        );
      }
    }
  }

  generateKeys(arMap);
  keysBuffer.writeln('}');
  File(keysFilePath).writeAsStringSync(keysBuffer.toString());

  print('🎯 Keys generated. Arabic is now dominant.');
}



// helper for Iterable.mapIndexed
extension IterableExtensions<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) sync* {
    int index = 0;
    for (final element in this) {
      yield f(index++, element);
    }
  }
}
