import '../../../imports/imports.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Text(
                title,
                style: context.s12w500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget? FieldIcon(IconData? iconData) {
  if (iconData == null) {
    return null;
  }
  return Icon(
    iconData,
    color: AppColors.grey.withValues(alpha: 0.5),
  );
}
