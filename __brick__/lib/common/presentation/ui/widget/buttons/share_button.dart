import 'package:share_plus/share_plus.dart';

import '../../../../imports/imports.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Share.share(message);
      },
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
