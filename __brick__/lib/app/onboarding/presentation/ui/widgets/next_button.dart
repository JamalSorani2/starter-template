import '../../../../../common/imports/imports.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        padding: REdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          height: 74.h,
          width: 74.h,
          alignment: Alignment.center,
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 32.sp,
          ),
        ),
      ),
    );
  }
}
