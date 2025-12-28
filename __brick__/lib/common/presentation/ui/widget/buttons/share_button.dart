import '../../../../imports/imports.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 36.h,
        width: 36.w,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppDesign.radius,
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.share, color: Colors.black),
      ),
    );
  }
}
