import '../../../../../common/imports/imports.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            await getIt<SharedPreferences>()
                .setBool(KOnboardingCompleted, true);

            context.goNamed(RoutesNames.login);
          },
          child: Text(
            AppString.skip,
            style: context.s28w400.copyWith(
              color: AppColors.grey.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
