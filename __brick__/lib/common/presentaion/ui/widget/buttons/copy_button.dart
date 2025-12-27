import 'package:flutter/services.dart';

import '../../../../imports/imports.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Copy',
      icon: const Icon(FontAwesomeIcons.copy),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: text));

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppString.copiedToClipboard),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
    );
  }
}
