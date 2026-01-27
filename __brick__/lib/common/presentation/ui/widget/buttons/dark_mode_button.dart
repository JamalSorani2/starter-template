import '../../../../imports/imports.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppDesign.horizontalPadding,
        vertical: AppDesign.verticalPadding / 2,
      ),
      child: Row(
        children: [
          const Icon(TablerIcons.eye),
          12.horizontalSpace,
          Expanded(
            child: TitleText(
              AppString.darkMode,
              fontWeight: FontWeight.w600,
            ),
          ),
          Consumer<ThemeProvider>(
            builder: (context, value, child) {
              return CustomSwitch(
                value: value.themeMode == ThemeMode.dark,
                onChanged: (_) => value.toggleTheme(),
                label: "",
              );
            },
          ),
        ],
      ),
    );
  }
}
