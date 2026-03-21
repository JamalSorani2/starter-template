import '../../../../../common/imports/imports.dart';
import '../../state/provider/counter_provider.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppString.codeNotSent,
          style: context.bodySmall,
        ),
        4.horizontalSpace,
        Consumer<CountdownProvider>(
          builder: (context, countdownProvider, child) {
            return InkWell(
              onTap: countdownProvider.isTimerRunning ? null : onTap,
              child: Text(
                countdownProvider.isTimerRunning
                    ? '${countdownProvider.remainingSeconds}'
                    : AppString.resendCode,
                style: context.bodySmall.copyWith(
                  color: AppColors.grey,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.grey,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
