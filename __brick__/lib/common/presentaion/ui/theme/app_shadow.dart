import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppShadows {
  const AppShadows._();

  //! Elevation 1 — cards, small containers
  static List<BoxShadow> get card => [
        BoxShadow(
          color: AppColors.shadow
              .withValues(alpha: AppColors.isLight ? 0.08 : 0.25),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  //! Elevation 2 — dialogs, sheets
  static List<BoxShadow> get md => [
        BoxShadow(
          color: AppColors.shadow
              .withValues(alpha: AppColors.isLight ? 0.12 : 0.35),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  //! Elevation 3 — modals, popups
  static List<BoxShadow> get lg => [
        BoxShadow(
          color: AppColors.shadow
              .withValues(alpha: AppColors.isLight ? 0.18 : 0.45),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];

  //! Soft shadow — inputs, subtle UI
  static List<BoxShadow> get soft => [
        BoxShadow(
          color: AppColors.shadow
              .withValues(alpha: AppColors.isLight ? 0.06 : 0.20),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ];

  //! Focus / glow — active elements
  static List<BoxShadow> glow(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 12,
          spreadRadius: 1,
        ),
      ];
}
