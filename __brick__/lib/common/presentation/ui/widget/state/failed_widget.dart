import '../../../../imports/imports.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    this.onRetry,
    this.message,
    this.details,
  });
  final Future<void> Function()? onRetry;
  final String? message;
  final FlutterErrorDetails? details;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: AppDesign.horizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Icon
            Icon(
              Icons.cloud_off_rounded,
              size: 64.sp,
              color: AppColors.primary,
            ),

            16.verticalSpace,

            Text(
              AppString.somethingWentWrong,
              style: context.titleLarge,
              textAlign: TextAlign.center,
            ),

            8.verticalSpace,

            Text(
              message ?? AppString.tryAgainLater,
              style: context.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            24.verticalSpace,

            CustomButton.primary(
              isLoading: false,
              onPressed: onRetry,
              text: AppString.tryAgain,
            ),
          ],
        ),
      ),
    );
  }
}
