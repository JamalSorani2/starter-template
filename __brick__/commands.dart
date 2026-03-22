// ignore_for_file: unused_element, avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart';

/// ----------- MAIN FUNCTION ------------
/// Run with: dart run commands.dart
void main() async {
  _printP('''
📦 Select a command to run:
1️⃣  Clean project and get dependencies
2️⃣  Clean project, get dependencies, and install iOS pods

🛠️  Build & Deploy
3️⃣  Build APK with custom name
4️⃣  Build APK with request inspect and custom name
5️⃣  Build App Bundle (AAB) with custom name

🧩 Code Generation
6️⃣  Run build runner

🔑 Keystore Management
7️⃣  Generate signing keystore 
8️⃣  Show keystore info (keytool)

────────────────────────────
🚪 0️⃣  Exit
''');

  stdout.write('🔢 Enter your choice (0-8): ');
  final input = stdin.readLineSync();

  switch (input) {
    case '1':
      await _cleanAndPubGet();
      break;
    case '2':
      await _cleanPubGetAndPodInstall();
      break;
    case '3':
      await _buildApkWithName();
      break;
    case '4':
      await _buildApkWithRequestInspectAndName();
      break;
    case '5':
      await _buildAppBundleWithName();
      break;
    case '6':
      await _runBuildRunner();
      break;
    case '7':
      await _generateSigningKeystore();
      break;
    case '8':
      await _showKeystoreInfo();
      break;
    case '0':
      _printG('👋 Exiting...');
      break;
    default:
      _printR('❌ Invalid option, please try again.');
  }
}

/// Runs a command and prints stdout and stderr with colors as they arrive.
Future<bool> _runCommand(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
}) async {
  _printC('🔄 Running: $executable ${arguments.join(' ')}');

  // Start loading animation
  bool loading = true;
  final loadingFuture = _showLoading(() => loading);

  final process = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    runInShell: true,
  );

  process.stdout
      .transform(const SystemEncoding().decoder)
      .transform(const LineSplitter())
      .listen((line) {
    _printW(line);
  });

  process.stderr
      .transform(const SystemEncoding().decoder)
      .transform(const LineSplitter())
      .listen((line) {
    _printW(line);
  });

  final exitCode = await process.exitCode;

  // Stop loading animation
  loading = false;
  await loadingFuture;

  if (exitCode == 0) {
    _printP('✅ Command completed successfully!');
    return true;
  } else {
    _printW('❌ Command failed with exit code $exitCode');
    return false;
  }
}

// Helper function for loading animation
Future<void> _showLoading(bool Function() isLoading) async {
  const loadingChars = ['|', '/', '-', '\\'];
  int i = 0;
  while (isLoading()) {
    stdout.write('\r⏳ Running... ${loadingChars[i % loadingChars.length]}');
    await Future.delayed(const Duration(milliseconds: 120));
    i++;
  }
  stdout.write('\r'); // Clear the loading line
}

/// === COMMONLY USED ===

Future<void> _cleanAndPubGet() async {
  _printP('🧹 Starting project cleanup...');
  final cleanSuccess = await _runCommand('flutter', ['clean']);
  _printP('📦 Getting dependencies...');
  final pubGetSuccess = await _runCommand('flutter', ['pub', 'get']);

  if (cleanSuccess && pubGetSuccess) {
    _printP('✨ Project cleaned and dependencies updated!');
  } else {
    _printW('❌ Project cleanup or dependency update failed!');
  }
}

Future<void> _runBuildRunner() async {
  _printP('⚙️  Running build runner for code generation...');
  final success = await _runCommand('dart', ['run', 'build_runner', 'build']);

  if (success) {
    _printP('✨ Code generation completed!');
  } else {
    _printW('❌ Code generation failed!');
  }
}

/// === BUILD & DEPLOY ===

Future<void> _buildApkWithName() async {
  _printP('📱 Building APK...');
  final buildSuccess = await _runCommand('flutter', [
    'build',
    'apk',
    '--release',
  ]);
  final appName = await _appName;
  if (buildSuccess) {
    if (appName != null) {
      final newName = appName.replaceAll(' ', '-');
      const src = 'build/app/outputs/flutter-apk/app-release.apk';
      final dest = 'build/app/outputs/flutter-apk/$newName.apk';
      if (await File(src).exists()) {
        await File(src).copy(dest);
        _printP('✅ APK renamed to $dest');
      } else {
        _printW('❌ APK file not found at $src');
      }
    } else {
      _printW('❌ App name not found!');
    }
  } else {
    _printW('❌ APK build failed!');
  }
}

Future<void> _buildApkWithRequestInspectAndName() async {
  _printP('🔍 Building APK with request inspection...');
  final buildSuccess = await _runCommand('flutter', [
    'build',
    'apk',
    '--release',
    '--dart-define=ENABLE_REQUEST_INSPECT=true',
  ]);
  final appName = await _appName;
  if (buildSuccess) {
    if (appName != null) {
      final newName = appName.replaceAll(' ', '-');
      const src = 'build/app/outputs/apk/release/app-release.apk';
      final dest = 'build/app/outputs/apk/release/$newName.apk';
      if (await File(src).exists()) {
        await File(src).copy(dest);
        _printP('✅ APK renamed to $dest');
      } else {
        _printW('❌ APK file not found at $src');
      }
    } else {
      _printW('❌ App name not found!');
    }
  } else {
    _printW('❌ APK build failed!');
  }
}

Future<void> _buildAppBundleWithName() async {
  _printP('📦 Building App Bundle (AAB)...');
  final buildSuccess = await _runCommand('flutter', [
    'build',
    'appbundle',
    '--release',
  ]);
  final appName = await _appName;
  if (buildSuccess) {
    if (appName != null) {
      final newName = appName.replaceAll(' ', '-');
      const src = 'build/app/outputs/bundle/release/app-release.aab';
      final dest = 'build/app/outputs/bundle/release/$newName.aab';
      if (await File(src).exists()) {
        await File(src).copy(dest);
        _printP('✅ App Bundle renamed to $dest');
      } else {
        _printW('❌ App Bundle file not found at $src');
      }
    } else {
      _printW('❌ App name not found!');
    }
  } else {
    _printW('❌ App Bundle build failed!');
  }
}

/// flutter clean, pub get, then pod install
Future<void> _cleanPubGetAndPodInstall() async {
  _printP('🍎 Starting iOS-specific cleanup...');
  final cleanSuccess = await _runCommand('flutter', ['clean']);
  _printP('📦 Getting dependencies...');
  final pubGetSuccess = await _runCommand('flutter', ['pub', 'get']);
  _printP('🗑️  Deleting Podfile.lock...');
  final podfileLock = File('ios/Podfile.lock');
  if (await podfileLock.exists()) {
    await podfileLock.delete();
    _printP('✅ Podfile.lock deleted');
  } else {
    _printP('ℹ️  Podfile.lock not found, skipping deletion');
  }
  _printP('📱 Installing iOS pods...');
  final podSuccess = await _runCommand(
    'pod',
    [
      'install',
    ],
    workingDirectory: 'ios',
  );

  if (cleanSuccess && pubGetSuccess && podSuccess) {
    _printP('✨ iOS setup completed!');
  } else {
    _printW('❌ iOS setup failed!');
  }
}

Future<String?> get _appName async {
  return await getAndroidAppLabel();
}

/// Extracts android:label from AndroidManifest.xml
Future<String?> getAndroidAppLabel() async {
  final file = File('android/app/src/main/AndroidManifest.xml');

  if (!await file.exists()) {
    print('❌ AndroidManifest.xml not found');
    return null;
  }

  final content = await file.readAsString();
  final document = XmlDocument.parse(content);
  final applicationElement = document.findAllElements('application').first;

  final label = applicationElement.getAttribute('android:label') ??
      applicationElement.getAttribute('label');

  return label;
}

/// === KEYTOOL ===

Future<Map<String, String>> _readKeyProperties() async {
  final file = File('android/key.properties');
  if (!await file.exists()) {
    _printR('❌ android/key.properties not found');
    return {};
  }
  final lines = await file.readAsLines();
  final Map<String, String> props = {};
  for (final line in lines) {
    final trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.startsWith('#')) {
      continue;
    }
    final idx = trimmed.indexOf('=');
    if (idx > 0) {
      final key = trimmed.substring(0, idx);
      final value = trimmed.substring(idx + 1);
      props[key] = value;
    }
  }
  return props;
}

Future<void> _showKeystoreInfo() async {
  _printP('🔑 Reading keystore info from android/key.properties...');
  final props = await _readKeyProperties();
  final storeFile = props['storeFile']?.replaceAll('..', 'android');
  final keyAlias = props['keyAlias'];
  final storePassword = props['storePassword'];
  if (storeFile == null || keyAlias == null || storePassword == null) {
    _printR('❌ Missing required properties in key.properties');
    return;
  }
  const command = 'keytool';
  final args = [
    '-list',
    '-v',
    '-keystore',
    storeFile,
    '-alias',
    keyAlias,
    '-storepass',
    storePassword,
  ];
  await _runCommand(command, args);
}

Future<void> _generateSigningKeystore() async {
  _printP('🔑 Generating signing keystore...');

  final keystoreDir = Directory('android/app');
  if (!await keystoreDir.exists()) {
    await keystoreDir.create(recursive: true);
  }

  const keystorePath = 'android/app/upload-keystore.jks';
  const password = 'qwerasdzx';
  const alias = 'upload';
  const validity = '10000';

  const dname = 'CN=Upload, OU=JA, O=JA, L=Aleppo, ST=Al, C=Syria';

  const command = 'keytool';
  final args = [
    '-genkey',
    '-v',
    '-keystore',
    keystorePath,
    '-alias',
    alias,
    '-keyalg',
    'RSA',
    '-keysize',
    '2048',
    '-validity',
    validity,
    '-storepass',
    password,
    '-keypass',
    password,
    '-dname',
    dname,
  ];

  final success = await _runCommand(command, args);

  if (success) {
    _printG('✅ Keystore generated successfully at $keystorePath');

    await _generateKeyPropertiesFile(password, alias, keystorePath);

    _printP('📝 Keystore details:');
    _printP('   - File: $keystorePath');
    _printP('   - Password: $password');
    _printP('   - Alias: $alias');
    _printP('   - Validity: $validity days');
    _printP('   - Certificate: $dname');

    final gitAddResult = await Process.run('git', [
      'add',
      '--force',
      keystorePath,
      'android/key.properties',
    ]);
    if (gitAddResult.exitCode == 0) {
      _printG('✅ Keystore and key.properties added to git (forced)');
    } else {
      _printR('❌ Failed to add files to git: \n');
      _printR(gitAddResult.stderr);
    }
  } else {
    _printR('❌ Failed to generate keystore');
  }
}

Future<void> _generateKeyPropertiesFile(
  String password,
  String alias,
  String keystorePath,
) async {
  _printP('📄 Generating key.properties file...');

  final keyPropertiesContent = '''storePassword=$password
keyPassword=$password
keyAlias=$alias
storeFile=../app/${keystorePath.split('/').last}
''';

  final keyPropertiesFile = File('android/key.properties');

  final androidDir = Directory('android');
  if (!await androidDir.exists()) {
    await androidDir.create();
  }

  await keyPropertiesFile.writeAsString(keyPropertiesContent);
  _printG('✅ key.properties file created at android/key.properties');
}

/// === CONSOLE COLORS ===

void _printB(Object? msg) {
  print('\x1B[34m$msg\x1B[0m');
}

void _printG(Object? msg) {
  print('\x1B[32m$msg\x1B[0m');
}

void _printY(Object? msg) {
  print('\x1B[33m$msg\x1B[0m');
}

void _printR(Object? msg) {
  print('\x1B[31m$msg\x1B[0m');
}

void _printW(Object? msg) {
  print('\x1B[37m$msg\x1B[0m');
}

void _printC(Object? msg) {
  print('\x1B[36m$msg\x1B[0m');
}

void _printK(Object? msg) {
  print('\x1B[30m$msg\x1B[0m');
}

void _printO(Object? msg) {
  print('\x1B[38;5;208m$msg\x1B[0m');
}

void _printP(Object? msg) {
  print('\x1B[38;5;93m$msg\x1B[0m');
}
