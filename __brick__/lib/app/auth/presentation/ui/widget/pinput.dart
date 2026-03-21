import 'package:pinput/pinput.dart';

import '../../../../../common/imports/imports.dart';

class PinPutWidget extends StatelessWidget {
  const PinPutWidget({
    super.key,
    required this.onCompleted,
    required this.controller,
  });
  final void Function(String) onCompleted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    final defaultTheme = PinTheme(
      width: 46.h,
      height: 46.h,
      textStyle: context.bodyMedium.copyWith(
        color: primary,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.5)),
        borderRadius: AppDesign.radius,
      ),
    );
    final focusedTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: primary),
      ),
    );
    return Center(
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: controller,
              autofocus: true,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              keyboardType: TextInputType.phone,
              errorTextStyle: TextStyle(fontSize: 8.sp),
              defaultPinTheme: defaultTheme,
              focusedPinTheme: focusedTheme,
              errorPinTheme: defaultTheme.copyWith(
                decoration: defaultTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.danger),
                ),
              ),
              submittedPinTheme: focusedTheme,
              cursor: Container(
                height: 20.h,
                width: 1.h,
                color: primary,
              ),
              length: 6,
              onCompleted: onCompleted,
              errorBuilder: (errorText, pin) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: REdgeInsets.only(top: 2.0),
                      child: Text(
                        errorText ?? AppString.incorrectPin,
                        style: context.labelSmall.copyWith(
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
