import '../../../../imports/imports.dart';

class TitleText extends StatelessWidget {
  const TitleText(
    this.data, {
    super.key,
    this.fontWeight,
    this.color,
  });
  final String data;
  final FontWeight? fontWeight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: context.titleMedium.copyWith(
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color,
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText(
    this.description, {
    super.key,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.textDirection,
  });
  final String description;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: maxLines,
      overflow: overflow,
      style: context.bodyMedium.copyWith(
        color: color ?? AppColors.textSecondary,
        fontWeight: fontWeight,
      ),
      textDirection: textDirection,
    );
  }
}

class SeeAllWidget extends StatelessWidget {
  const SeeAllWidget({
    super.key,
    required this.title,
    required this.onSeeAll,
    this.withHorizentalPadding = true,
    this.textStyle,
    required this.withSeeAll,
    this.icon,
  });
  final String title;
  final void Function() onSeeAll;
  final bool withHorizentalPadding;
  final TextStyle? textStyle;
  final bool withSeeAll;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: withHorizentalPadding ? AppDesign.horizontalPadding : 0,
        vertical: !withSeeAll ? 12 : 0,
      ),
      child: Row(
        children: [
          if (icon != null) ...[icon!, 8.horizontalSpace],
          Text(
            title,
            style: textStyle ?? context.titleLarge,
          ),
          const Spacer(),
          if (withSeeAll)
            TextButton(
              onPressed: onSeeAll,
              child: Text(
                AppString.seeAll,
                style: context.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SeeMoreDesciption extends StatefulWidget {
  const SeeMoreDesciption(this.text, {super.key});
  final String text;

  @override
  State<SeeMoreDesciption> createState() => _SeeMoreDesciptionState();
}

class _SeeMoreDesciptionState extends State<SeeMoreDesciption> {
  bool _expanded = false;
  bool _isOverflowing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkOverflow();
  }

  void _checkOverflow() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: context.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      maxLines: 3,
      textDirection: context.isLTR ? TextDirection.ltr : TextDirection.rtl,
    )..layout(maxWidth: context.screenWidth);

    _isOverflowing = textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DescriptionText(
          widget.text,
          maxLines: _expanded ? null : 3,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (_isOverflowing)
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Padding(
              padding: REdgeInsets.only(top: 4),
              child: Text(
                _expanded ? AppString.readLess : AppString.readMore,
                style: context.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class LabelText extends StatelessWidget {
  const LabelText(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textDirection,
  });
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDirection? textDirection;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.labelSmall.copyWith(color: color, fontWeight: fontWeight),
      textDirection: textDirection,
    );
  }
}
