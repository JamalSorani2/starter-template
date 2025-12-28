import 'package:bot_toast/bot_toast.dart';

import '../../theme/app_colors.dart';

void showSuccessToast(String text) {
  BotToast.showText(text: text, contentColor: AppColors.success);
}

void showDangerToast(String text) {
  BotToast.showText(text: text, contentColor: AppColors.danger);
}

void showWarningToast(String text) {
  BotToast.showText(text: text, contentColor: AppColors.warning);
}

void showToast(String text) {
  BotToast.showText(
    text: text,
  );
}
