// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    print('Error: pubspec.yaml not found in the current directory.');
    exit(1);
  }

  final lines = file.readAsLinesSync();
  final buffer = StringBuffer();

  bool inDependenciesSection = false;
  final dependencyLines = <String>[];

  // Regex to find "dependencies:" at the start of a line (ignoring dev_dependencies)
  final dependenciesStart = RegExp(r'^dependencies:\s*$');

  // Regex to detect the start of a new section (e.g., dev_dependencies:, flutter:)
  // Must start with a letter and have no indentation.

  for (final line in lines) {
    if (inDependenciesSection) {
      // Check if the section has ended
      if (line.trim().isNotEmpty &&
          !line.startsWith(' ') &&
          !line.startsWith('#')) {
        // We hit a new root-level key (like dev_dependencies:), so we are done.
        _processAndWriteDependencies(buffer, dependencyLines);
        inDependenciesSection = false;
        buffer.writeln(line);
      } else {
        // We are inside dependencies.
        // We collect lines but skip existing comments/headers to regenerate them clean.
        if (line.trim().isNotEmpty && !line.trim().startsWith('#')) {
          dependencyLines.add(line);
        }
      }
    } else {
      buffer.writeln(line);
      if (dependenciesStart.hasMatch(line)) {
        inDependenciesSection = true;
      }
    }
  }

  // If the file ended while we were still in the dependencies section
  if (inDependenciesSection) {
    _processAndWriteDependencies(buffer, dependencyLines);
  }

  // Write changes back to file
  file.writeAsStringSync(buffer.toString());
  print('Dependencies sorted successfully.');
}

void _processAndWriteDependencies(StringBuffer buffer, List<String> rawLines) {
  final Map<String, String> parsedDeps = {};
  String? currentKey;

  // 1. Parse raw lines into a Map to handle multi-line dependencies (like flutter sdk)
  for (final line in rawLines) {
    // A new dependency usually starts with exactly 2 spaces indentation
    if (line.startsWith('  ') && !line.startsWith('   ')) {
      final match = RegExp(r'^\s\s([a-zA-Z0-9_]+):').firstMatch(line);
      if (match != null) {
        currentKey = match.group(1);
        parsedDeps[currentKey!] = line;
      }
    } else if (currentKey != null) {
      // This line belongs to the previous key (e.g., sdk: flutter indentation)
      parsedDeps[currentKey] = '${parsedDeps[currentKey]}\n$line';
    }
  }

  // 2. Sort keys
  final sortedKeys = parsedDeps.keys.toList()..sort();

  // 3. Generate output with headers
  String? lastChar;

  for (final key in sortedKeys) {
    final firstChar = key[0].toLowerCase();

    if (firstChar != lastChar) {
      // Add a blank line before new group (except the very first one)
      if (lastChar != null) {
        buffer.writeln();
      }
      // Add the header
      buffer.writeln('  #$firstChar');
      lastChar = firstChar;
    }

    buffer.writeln(parsedDeps[key]);
  }
}
