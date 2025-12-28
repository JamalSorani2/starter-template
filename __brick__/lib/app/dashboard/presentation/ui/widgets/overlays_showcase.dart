import '/common/imports/imports.dart';
import '/common/presentation/ui/widget/overlays/leave_dialog.dart';

import '../../../../../common/presentation/ui/widget/overlays/snack_bar.dart';
import '../../../../../common/presentation/ui/widget/overlays/toast.dart';

class OverlaysShowcase extends StatelessWidget {
  const OverlaysShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overlays Showcase', style: tt.displayLarge),
        CustomDivider(height: 4.h, margin: REdgeInsets.symmetric(vertical: 8)),

        // Dialogs
        CustomCard(
          header: Text('Dialogs', style: tt.titleLarge),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              CustomButton.primary(
                text: 'Show Dialog',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => CustomDialog(
                      headerIcon: Icon(Icons.info, color: AppColors.primary),
                      headerTitle: 'Custom Dialog',
                      subTitleWidget: Text(
                        'Use this dialog to confirm or show information.',
                        style: tt.bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                      body: Text(
                        'This is the dialog body area. Add any widget here.',
                        style: tt.bodyMedium,
                      ),
                      primaryText: 'Confirm',
                      cancelText: 'Close',
                      onPrimaryTap: () {
                        Navigator.of(context).pop();
                        showSuccessToast('Confirmed');
                      },
                    ),
                  );
                },
              ),
              CustomButton.outlined(
                text: 'Leave Dialog',
                onPressed: () {
                  showLeaveDialog(context);
                },
              ),
            ],
          ),
        ),
        16.verticalSpace,

        // Bottom Sheets
        CustomCard(
          header: Text('Bottom Sheets', style: tt.titleLarge),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              CustomButton.primary(
                text: 'Show Bottom Sheet',
                onPressed: () async {
                  await showCustomBottomSheet(
                    context: context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bottom Sheet Title', style: tt.titleLarge),
                        12.verticalSpace,
                        Text(
                          'This is a custom bottom sheet. Put your form or actions here.',
                          style: tt.bodyMedium,
                        ),
                        16.verticalSpace,
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomButton.primary(
                            text: 'Close',
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        16.verticalSpace,

        // Snackbars
        CustomCard(
          header: Text('Snackbars', style: tt.titleLarge),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              CustomButton.primaryText(
                text: 'Primary',
                onPressed: () => showGlobalSnackbar(message: 'Primary message'),
              ),
              CustomButton.primaryText(
                text: 'Success',
                onPressed: () => showGlobalSnackbar(
                  message: 'Saved successfully',
                  isSuccess: true,
                ),
              ),
              CustomButton.primaryText(
                text: 'Warning',
                onPressed: () => showGlobalSnackbar(
                  message: 'Please verify your input',
                  isWarning: true,
                ),
              ),
              CustomButton.primaryText(
                text: 'Error',
                onPressed: () => showGlobalSnackbar(
                  message: 'Something went wrong',
                  isError: true,
                ),
              ),
            ],
          ),
        ),
        16.verticalSpace,

        // Toasts
        CustomCard(
          header: Text('Toasts', style: tt.titleLarge),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              CustomButton.secondary(
                text: 'Toast',
                onPressed: () => showToast('Hello Toast'),
              ),
              CustomButton.secondary(
                text: 'Success',
                onPressed: () => showSuccessToast('Success'),
              ),
              CustomButton.secondary(
                text: 'Warning',
                onPressed: () => showWarningToast('Warning'),
              ),
              CustomButton.secondary(
                text: 'Error',
                onPressed: () => showDangerToast('Error'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
