import '../../../../imports/imports.dart';

Future<bool> showLeaveDialog(BuildContext context) async {
  bool result = false;

  await showDialog(
    context: context,
    builder: (context) => CustomDialog(
      headerIcon: const Icon(
        Icons.warning_amber_rounded,
        size: 40,
        color: Colors.amber,
      ),
      headerTitle: AppString.leavePage,
      body: Text(
        AppString.areYouSureYouWantToLeave,
        style: context.bodySmall,
      ),
      primaryText: AppString.yesLeave,
      onPrimaryTap: () {
        result = true;
        Navigator.of(context).pop();
      },
    ),
  );

  return result;
}
