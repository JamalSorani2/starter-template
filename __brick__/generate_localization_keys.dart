// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

// dart run generate_localization_keys.dart

void main() {
  const arFilePath = 'assets/l10n/ar.json';
  const enFilePath = 'assets/l10n/en.json';
  const keysFilePath = 'lib/common/translate/app_string.dart';

  // ---------- Load en.json ----------
  final enFile = File(enFilePath);
  if (!enFile.existsSync()) {
    print('❌ Error: en.json not found.');
    return;
  }
  final Map<String, dynamic> enMapOriginal = jsonDecode(
    enFile.readAsStringSync(),
  );

  String cleanTextToKey(String text) {
    // Remove all characters except letters, numbers and spaces
    final cleaned = text.replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '');

    // Split words
    final words =
        cleaned.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

    if (words.isEmpty) {
      return 'emptyKey';
    }

    // camelCase
    final first = words.first.toLowerCase();
    final rest = words
        .skip(1)
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join();

    return first + rest;
  }

  // ---------- Preprocess empty keys "" ----------
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

  fixEmptyKeys(enMapOriginal);

  // ---------- Remove duplicate values in en.json ----------
  final Map<String, dynamic> enMap = {};
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
          print(
            "❌ Duplicate value removed from en.json: key=$key, value=$value",
          );
        }
      }
    });
  }

  removeDuplicates(enMapOriginal, enMap);

  // Save cleaned en.json
  enFile.writeAsStringSync(const JsonEncoder.withIndent('    ').convert(enMap));
  print("✅ en.json cleaned, empty keys fixed, duplicates removed.");

  // ---------- Load ar.json ----------
  final arFile = File(arFilePath);
  if (!arFile.existsSync()) {
    print('❌ Error: ar.json not found.');
    return;
  }
  final Map<String, dynamic> arMap = jsonDecode(arFile.readAsStringSync());

  // ---------- Remove keys from ar.json that do NOT exist in en.json ----------
  bool removed = false;

  void removeExtraKeys(Map<String, dynamic> ar, Map<String, dynamic> en) {
    final keysToRemove = <String>[];
    ar.forEach((key, value) {
      if (!en.containsKey(key)) {
        keysToRemove.add(key);
      } else if (value is Map<String, dynamic> &&
          en[key] is Map<String, dynamic>) {
        removeExtraKeys(value, en[key]);
      }
    });
    for (final key in keysToRemove) {
      ar.remove(key);
      removed = true;
      print("🗑 Removed extra key from ar.json: $key");
    }
  }

  removeExtraKeys(arMap, enMap);

  // ---------- Sync missing keys from en → ar ----------
  bool updated = false;

  void syncMissing(Map<String, dynamic> en, Map<String, dynamic> ar) {
    en.forEach((key, value) {
      if (!ar.containsKey(key)) {
        ar[key] = ""; // Or ar[key] = value; to copy English
        print("➕ Added missing key to ar.json: $key");
        updated = true;
      } else if (value is Map<String, dynamic>) {
        if (ar[key] is! Map) {
          ar[key] = {};
        }
        syncMissing(value, ar[key]);
      }
    });
  }

  syncMissing(enMap, arMap);

  // Save ar.json if changed
  if (updated || removed) {
    arFile
        .writeAsStringSync(const JsonEncoder.withIndent('    ').convert(arMap));
    print("✅ ar.json updated (synced missing keys, removed extra keys).");
  } else {
    print("✔ ar.json already matches en.json keys.");
  }

  // ---------- Generate Dart localization keys ----------
  Directory(
    keysFilePath.substring(0, keysFilePath.lastIndexOf('/')),
  ).createSync(recursive: true);

  final keysBuffer = StringBuffer();

  keysBuffer.writeln('''
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/easy_localization_controller.dart';
import 'package:easy_localization/src/localization.dart';
import '../imports/imports.dart';
import 'app_local.dart';

// dart run generate_localization_keys.dart
class AppString {
  static final Localization _localization = Localization.instance;
  Future<void> loadTranslations() async {
    await EasyLocalizationController.initEasyLocation();
    final controller = EasyLocalizationController(
      saveLocale: true,
      fallbackLocale: AppLocale.fallbackLocale,
      supportedLocales: AppLocale.supportedLocales,
      assetLoader: const RootBundleAssetLoader(),
      useOnlyLangCode: false,
      useFallbackTranslations: true,
      path: AppLocale.path,
      onLoadError: (FlutterError e) {},
    );
    await controller.loadTranslations();
    Localization.load(
      controller.locale,
      translations: controller.translations,
      fallbackTranslations: controller.fallbackTranslations,
    );
  }''');

  void generateKeys(Map<String, dynamic> map, [String prefix = '']) {
    for (final entry in map.entries) {
      final key = entry.key;
      final value = entry.value.toString().replaceAll('\n', '');
      final newKey = key.contains('_') ? _toCamelCase(key) : key;
      final fullKey = prefix.isNotEmpty ? '$prefix.$key' : key;

      if (entry.value is Map) {
        generateKeys(entry.value, fullKey);
      } else {
        keysBuffer.writeln();
        keysBuffer.writeln("  /// $value");
        keysBuffer.writeln(
          "  static String get $newKey => _localization.tr('$fullKey');",
        );
      }
    }
  }

  generateKeys(enMap);

  keysBuffer.writeln('}');

  File(keysFilePath).writeAsStringSync(keysBuffer.toString());
  print('🎯 Localization keys generated & ar.json synced successfully.');
}

// snake_case → camelCase
String _toCamelCase(String text) {
  return text.split(RegExp(r'\s+|_|-')).mapIndexed((index, word) {
    if (index == 0) {
      return word.toLowerCase();
    }
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join();
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
