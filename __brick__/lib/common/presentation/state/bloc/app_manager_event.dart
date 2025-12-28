part of 'app_manager_bloc.dart';

abstract class AppManagerEvent {
  const AppManagerEvent();
}

class AppManagerStarted extends AppManagerEvent {}

class AppManageStatusChanged extends AppManagerEvent {
  final String? message;
  final Status status;

  const AppManageStatusChanged({this.message, required this.status});
}

class AppManagerLoggedOut extends AppManagerEvent {
  final String? message;

  const AppManagerLoggedOut({this.message});
}

class AppMangerExpiredApp extends AppManagerEvent {
  final bool updateRequired;
  final bool canUpdateLater;
  final String? enWhatIsNew;
  final String? arWhatIsNew;
  final String newVersion;

  AppMangerExpiredApp({
    required this.updateRequired,
    required this.canUpdateLater,
    required this.enWhatIsNew,
    required this.arWhatIsNew,
    required this.newVersion,
  });
}

class AppMangerUnExpiredApp extends AppManagerEvent {}
