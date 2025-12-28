import '../../../imports/imports.dart';
import '../../../services/storage_service/internet_status_service.dart';

class InternetBanner extends StatelessWidget {
  const InternetBanner({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppString.noInternetConnection,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
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
