part of 'app_manager_bloc.dart';

class AppManagerState {
  const AppManagerState({
    required this.status,
    this.message,
    this.updateRequired = false,
    this.canUpdateLater = false,
    this.arWhatIsNew,
    this.enWhatIsNew,
    this.newVersion = '',
  });

  final Status status;
  final String? message;
  final bool updateRequired;
  final bool canUpdateLater;
  final String? enWhatIsNew;
  final String? arWhatIsNew;
  final String newVersion;

  AppManagerState copyWith({
    Status? status,
    String? message,
    bool? updateRequired,
    bool? canUpdateLater,
    String? enWhatIsNew,
    String? arWhatIsNew,
    String? newVersion,
  }) {
    return AppManagerState(
      status: status ?? this.status,
      message: message ?? this.message,
      updateRequired: updateRequired ?? this.updateRequired,
      canUpdateLater: canUpdateLater ?? this.canUpdateLater,
      enWhatIsNew: enWhatIsNew ?? this.enWhatIsNew,
      arWhatIsNew: arWhatIsNew ?? this.arWhatIsNew,
      newVersion: newVersion ?? this.newVersion,
    );
  }
}
