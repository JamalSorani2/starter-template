import '../../../../imports/imports.dart';

class DeleteButton extends StatelessWidget {
  final void Function() onTap;
  final bool isLoading;
  const DeleteButton({
    super.key,
    required this.onTap,
    required this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30.h,
        width: 30.w,
        decoration: const BoxDecoration(
          color: AppColors.danger,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: isLoading
            ? LoadingProgress(
                size: 20.h,
                color: Colors.white,
              )
            : const Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
      ),
    );
  }
}
