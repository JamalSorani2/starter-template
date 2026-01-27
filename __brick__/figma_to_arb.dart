// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:translator/translator.dart';

final translator = GoogleTranslator();

void main() async {
  final figmaFile = File('assets/l10n/figma.json');
  final arFile = File('assets/l10n/ar.json');

  if (!await figmaFile.exists() || !await arFile.exists()) {
    print('❌ Missing files');
    return;
  }

  final List<dynamic> figmaData = jsonDecode(await figmaFile.readAsString());
  final Map<String, dynamic> arMap = jsonDecode(await arFile.readAsString());

  int added = 0;

  for (final item in figmaData) {
    final text = item['layer_name']?.toString().trim();
    if (text == null || text.isEmpty) {
      continue;
    }

    // 🚫 Skip numbers only (e.g. "73")
    if (RegExp(r'^\d+$').hasMatch(text)) {
      print('🔢 Skipped number-only: $text');
      continue;
    }

    // 🌍 Translate Arabic → English
    final translation = await translator.translate(text, from: 'ar');
    final english = translation.text;

    // 🔑 Generate key
    final key = toCamelCase(english);

    if (key.isEmpty) {
      print('⚠️ Skipped invalid key from: $text');
      continue;
    }

    // ➕ Add only if not exists
    if (!arMap.containsKey(key)) {
      arMap[key] = text;
      added++;
      print('Added: $key');
    }
  }

  await arFile.writeAsString(const JsonEncoder.withIndent('  ').convert(arMap));
  print('\n✅ Done. Added $added keys.');
}

String toCamelCase(String text) {
  // Remove emojis, punctuation, symbols
  text = text
      .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim()
      .toLowerCase();

  if (text.isEmpty) {
    return '';
  }

  final words = text.split(' ').where((w) => w.isNotEmpty).toList();
  if (words.isEmpty) {
    return '';
  }

  return words.first +
      words.skip(1).map((w) => w[0].toUpperCase() + w.substring(1)).join();
}
