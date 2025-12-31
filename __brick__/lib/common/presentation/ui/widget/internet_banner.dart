import '../../../imports/imports.dart';

class InternetBanner extends StatelessWidget {
  const InternetBanner({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      key: const Key('internetBanner'),
      stream: InternetStatusService.connectionStatusController.stream,
      initialData: true,
      builder: (context, snapshot) {
        final connected = snapshot.data ?? true;
        if (connected) {
          return child;
        }

        return Column(
          children: [
            Material(
              color: AppColors.danger,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: context.paddingTop + 8.h,
                    bottom: 8.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.noInternetConnection,
                        textAlign: TextAlign.center,
                        style: context.s16w400.copyWith(color: Colors.white),
                      ),
                      8.horizontalSpace,
                      LoadingProgress(
                        size: 24.r,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}
