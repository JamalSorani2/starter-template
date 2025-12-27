import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetStatusService {
  InternetStatusService._();

  static StreamController<bool> connectionStatusController =
      StreamController<bool>.broadcast();
  static final internetConnectionChecker =
      InternetConnectionChecker.createInstance();

  static void initialize() {
    // 1) Listen to network changes (wifi/mobile/none)
    Connectivity().onConnectivityChanged.listen((status) async {
      final hasInternet = await internetConnectionChecker.hasConnection;
      connectionStatusController.add(hasInternet);
    });

    // 2) Periodic Internet check (optional)
    internetConnectionChecker.onStatusChange.listen((event) {
      connectionStatusController
          .add(event == InternetConnectionStatus.connected);
    });
  }
}
