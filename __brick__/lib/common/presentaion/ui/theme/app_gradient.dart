import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppGradients {
  const AppGradients._();

  //! Primary Gradient — brand main gradient
  static LinearGradient get primary => LinearGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0.9),
          AppColors.primary.withValues(alpha: 0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  //! Secondary Gradient — accent / highlight
  static LinearGradient get secondary => LinearGradient(
        colors: [
          AppColors.secondary.withValues(alpha: 0.9),
          AppColors.secondary.withValues(alpha: 0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  //! Background gradient — subtle background effect
  static LinearGradient get background => LinearGradient(
        colors: [
          AppColors.surface,
          AppColors.card,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  //! Overlay gradient — for modals or overlays
  static LinearGradient get overlay => LinearGradient(
        colors: [
          AppColors.overlay.withValues(alpha: 0.0),
          AppColors.overlay.withValues(alpha: 0.5),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  //! Success Gradient
  static LinearGradient get success => LinearGradient(
        colors: [
          AppColors.success.withValues(alpha: 0.9),
          AppColors.success.withValues(alpha: 0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  //! Warning Gradient
  static LinearGradient get warning => LinearGradient(
        colors: [
          AppColors.warning.withValues(alpha: 0.9),
          AppColors.warning.withValues(alpha: 0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  //! Danger Gradient
  static LinearGradient get danger => LinearGradient(
        colors: [
          AppColors.danger.withValues(alpha: 0.9),
          AppColors.danger.withValues(alpha: 0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
