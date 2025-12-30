import '../../../../../app/app.dart';
import '../../../../imports/imports.dart';

void showGlobalSnackbar({
  required String message,
  bool isError = false,
  bool isWarning = false,
  bool isSuccess = false,
  Duration duration = const Duration(seconds: 2),
  Color? backgroundColor,
  Color? textColor,
}) {
  final messenger = rootScaffoldMessengerKey.currentState;
  if (messenger == null) {
    return;
  }

  final Color bgColor = backgroundColor ??
      (isSuccess
          ? AppColors.success
          : (isWarning
              ? AppColors.warning
              : (isError ? AppColors.danger : AppColors.primary)));
  final fgColor = textColor ?? AppColors.onSecondary;

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: fgColor, fontWeight: FontWeight.w500),
      ),
      backgroundColor: bgColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
  );
}
