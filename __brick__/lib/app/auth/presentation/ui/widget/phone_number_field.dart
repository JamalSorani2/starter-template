
import '/common/imports/imports.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    super.key,
    required this.controller,
    this.title,
    this.textInputAction = TextInputAction.next,
    this.onSubmit,
  });
  final PhoneController controller;
  final String? title;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmit;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField>
    with WidgetsBindingObserver {
  final _focusNode = FocusNode();
  bool _keyboardOpen = false;
  final _fieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final view = View.of(context);
    final bottomInset = view.viewInsets.bottom;
    final keyboardVisible = bottomInset > 0;

    // Keyboard just closed
    if (_keyboardOpen && !keyboardVisible) {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    }

    _keyboardOpen = keyboardVisible;
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.title != null) TitleWidget(title: widget.title!),
        Directionality(
          textDirection: TextDirection.ltr,
          child: PhoneFormField(
            key: _fieldKey,
            focusNode: _focusNode,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              hintText: AppString.phoneNumber,
              hintTextDirection:
                  context.isLTR ? TextDirection.ltr : TextDirection.rtl,
              suffixIcon: FieldIcon(TablerIcons.phone),
            ),
            countryButtonStyle: CountryButtonStyle(
              padding: REdgeInsets.only(left: 16, right: 16),
              dropdownIconColor: AppColors.textDisabled,
            ),
            onTapUpOutside: (control) {
              _focusNode.unfocus();
            },
            onTap: () {
              _scrollToFieldOnTap();
            },
            onTapOutside: (event) {
              _focusNode.unfocus();
            },
            validator: (PhoneNumber? p) {
              if (p == null || p.nsn.isEmpty) {
                return AppString.phoneNumberIsRequired;
              }
              if (!p.isValid()) {
                return AppString.phoneNumberIsInvalid;
              }
              return null;
            },
            onSubmitted: (value) {
              widget.onSubmit?.call();
            },
          ),
        ),
      ],
    );
  }

  void _scrollToFieldOnTap() async {
    while (MediaQuery.of(context).viewInsets.bottom < 100) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    try {
      final context = _fieldKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          alignment: 0.1,
        );
      }
    } catch (e) {
      printR(e.toString());
    }
  }
}

void setPhoneNumberFromString({
  required PhoneController phoneNumberController,
  required String fullNumber,
}) {
  if (fullNumber.isEmpty) {
    return;
  }

  try {
    final phoneNumber = PhoneNumber.parse(fullNumber);
    phoneNumberController.value = phoneNumber;
  } catch (_) {
    // ignore invalid phone format
  }
}
