import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'imports/imports.dart';

String? KDirectoryPath;

Future<String?> getDirectoryPath() async {
  if (KDirectoryPath != null) {
    return KDirectoryPath;
  }
  if (await isAndroid10()) {
    KDirectoryPath = await getAndoid10Directory();
    return KDirectoryPath;
  } else if (Platform.isIOS) {
    KDirectoryPath = await getIosDirectory();
    return KDirectoryPath;
  }
  final Directory downloadsDir = Directory('/storage/emulated/0/Download');
  if (!await downloadsDir.exists()) {
    await downloadsDir.create(recursive: true);
  }
  KDirectoryPath = downloadsDir.path;
  return KDirectoryPath;
}

Future<String?> getAndoid10Directory() async {
  final isGranted = await Permission.storage.isGranted;
  if (!isGranted) {
    final PermissionStatus permissionStatus =
        await Permission.storage.request();
    if (permissionStatus.isDenied) {
      return null;
    }
  }
  final Directory? directory = await getExternalStorageDirectory();
  if (directory == null) {
    return null;
  }
  final downloadsDir = Directory('${directory.path}/Download');
  if (!await downloadsDir.exists()) {
    await downloadsDir.create(recursive: true);
  }
  return directory.path;
}

Future<String?> getIosDirectory() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

String getFilename(String contentDisposition) {
  // This regex will match the filename in the content-disposition header
  final RegExp regex = RegExp(r'filename="?([^";]+)"?');
  final match = regex.firstMatch(contentDisposition);
  // Return the filename part, removing any surrounding quotes
  String result = match?.group(1)?.replaceAll('"', '') ?? '';
  result = result
      .replaceAll('/', '-')
      .replaceAll(' ', '')
      .replaceAll("'", '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '')
      .replaceAll(':', '')
      .replaceAll('!', '');

  return result;
}

Future<bool> isAndroid10() async {
  if (!Platform.isAndroid) {
    return false;
  }
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;

  final int sdkInt = androidInfo.version.sdkInt;
  return sdkInt <= 29;
}

Future<void> openFile(Response response) async {
  String fileName = getFilename(
    response.headers.value('content-disposition') ?? '',
  ).trim();

  if (fileName.isEmpty) {
    fileName = 'invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';
  }

  if (response.statusCode != 200) {
    throw AppException.unknown();
  }

  if (Platform.isIOS) {
    printR('iOS: Response data type: ${response.data.runtimeType}');
    printR('iOS: Response data length: ${response.data.length}');
    printR('iOS: Response status code: ${response.statusCode}');
    printR('iOS: Response headers: ${response.headers}');

    if (response.data.length == 0) {
      printR('iOS: Empty response data - cannot save PDF');
      {
        return;
      }
    }

    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = '${appDocDir.path}/$fileName.pdf';
    printO('filePath: $filePath');
    final file = File(filePath);

    if (response.data is List<int>) {
      await file.writeAsBytes(response.data);
    } else {
      printR('iOS: Converting response data to bytes');
      final bytes = response.data.toString().codeUnits;
      await file.writeAsBytes(bytes);
    }
  }
  final dirPath = await getDirectoryPath();
  if (dirPath == null) {
    return;
  }

  final String filePath =
      '${dirPath.endsWith('/') ? dirPath : '$dirPath/'}$fileName.pdf';
  final file = File(filePath);
  await file.writeAsBytes(response.data);
  printO(filePath);
  OpenFilex.open(filePath);
}
