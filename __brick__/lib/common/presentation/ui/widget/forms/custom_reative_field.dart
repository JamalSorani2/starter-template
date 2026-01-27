import '/common/helper/validation_helper.dart';
import '../../../../imports/imports.dart';

class CustomReactiveField extends StatefulWidget {
  final String controller;

  // Field properties
  final String? title;
  final String? hintText;
  final bool readOnly;
  final bool autoFocus;
  final bool isPassword;
  final String? minLengthValidator;
  final TextDirection? textDirection;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  // Prefix and suffix widgets
  final IconData? prefixIcon;
  final IconData? asset;
  final IconData? suffixPassIcon;

  // Actions
  final void Function(FormControl controller)? onTap;
  final Function(FormControl<dynamic>)? onChanged;
  final void Function(FormControl<dynamic>)? onSubmitted;

  CustomReactiveField({
    super.key,
    required this.controller,
    this.title,
    this.hintText,
    this.readOnly = false,
    this.autoFocus = false,
    this.isPassword = false,
    this.minLengthValidator,
    this.textDirection,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.asset,
    this.suffixPassIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<CustomReactiveField> createState() => _CustomReactiveFieldState();
}

class _CustomReactiveFieldState extends State<CustomReactiveField> {
  final _focusNode = FocusNode();
  final _fieldKey = GlobalKey();
  late bool _hidden;

  @override
  void initState() {
    super.initState();
    _hidden = widget.isPassword;

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _fieldKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          TitleWidget(
            title: widget.title!,
          ),
        ReactiveTextField(
          formControlName: widget.controller,
          readOnly: widget.readOnly,
          focusNode: _focusNode,
          onTap: (control) {
            widget.onTap?.call(control);
            _scrollToFieldOnTap();
          },
          onTapUpOutside: (control) {
            _focusNode.unfocus();
          },
          onSubmitted: widget.onSubmitted,
          keyboardType: widget.keyboardType,
          textDirection: widget.textDirection ,
          textInputAction: widget.textInputAction,
          validationMessages:
              ValidationHelper.validationMessages(widget.minLengthValidator),
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintTextDirection: widget.hintText.textDirection,
            prefixIcon: FieldIcon(widget.prefixIcon),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedCrossFade(
                          alignment: Alignment.centerRight,
                          firstChild:
                              FieldIcon(widget.asset) ?? const SizedBox(),
                          secondChild: FieldIcon(widget.suffixPassIcon) ??
                              const SizedBox(),
                          crossFadeState: _hidden
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 400),
                        ),
                      ],
                    ),
                  )
                : FieldIcon(widget.asset) ?? FieldIcon(widget.suffixPassIcon),
          ),
          cursorColor: AppColors.primary,
          obscureText: _hidden,
        ),
      ],
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  void _scrollToFieldOnTap() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
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
    });
  }
}
