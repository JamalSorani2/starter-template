import '/common/imports/imports.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    super.key,
    required this.controller,
    this.title,
    this.isRequired = true,
    this.textInputAction = TextInputAction.next,
    this.onSubmit,
    this.onChanged,
    this.validationMessage,
    this.readOnly = false,
    this.withSuffix = true,
  });
  final PhoneController controller;
  final String? title;
  final bool isRequired;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmit;
  final String? validationMessage;
  final Function(String)? onChanged;
  final bool readOnly;
  final bool withSuffix;

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
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (!mounted) {
      return;
    }
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

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (!mounted) {
          return;
        }
        _scrollToFieldOnTap();
      });
    }
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
            controller: widget.controller,
            enabled: !widget.readOnly,
            focusNode: _focusNode,
            style: context.bodyMedium,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: AppString.phoneNumber,
              hintTextDirection:
                  context.isLTR ? TextDirection.ltr : TextDirection.rtl,
              suffixIcon:
                  widget.withSuffix ? FieldIcon(TablerIcons.phone) : null,
            ),
            countryButtonStyle: CountryButtonStyle(
              padding: REdgeInsets.only(left: 16, right: 16),
              dropdownIconColor: AppColors.textDisabled,
            ),
            validator: (PhoneNumber? p) {
              if (widget.readOnly) {
                return null;
              }
              if (p == null || p.nsn.isEmpty) {
                if (!widget.isRequired) {
                  return null;
                }
                return widget.validationMessage ??
                    AppString.phoneNumberIsRequired;
              }
              if (!p.isValid()) {
                return AppString.phoneNumberIsInvalid;
              }
              return null;
            },
            onTap: () {
              _scrollToFieldOnTap();
            },
            onSubmitted: (_) {
              widget.onSubmit?.call();
            },
            onChanged: (value) {
              widget.onChanged?.call(value.nsn);
            },
          ),
        ),
      ],
    );
  }

  void _scrollToFieldOnTap() async {
    while (mounted) {
      final fieldContext = _fieldKey.currentContext;
      if (fieldContext == null) {
        return;
      }
      if (MediaQuery.of(fieldContext).viewInsets.bottom >= 100) {
        break;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
    if (!mounted) {
      return;
    }
    try {
      final fieldContext = _fieldKey.currentContext;
      if (fieldContext != null) {
        Scrollable.ensureVisible(
          fieldContext,
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

String? getPhoneNumber(PhoneController controller) {
  if (controller.value.nsn.isEmpty) {
    return null;
  }
  return controller.value.countryCode + controller.value.nsn;
}
