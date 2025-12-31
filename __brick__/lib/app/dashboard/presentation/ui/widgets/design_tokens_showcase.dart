import '/common/imports/imports.dart';

class DesignTokensShowcase extends StatelessWidget {
  const DesignTokensShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Design Tokens Showcase',
          style: tt.displayLarge,
        ),
        CustomDivider(
          height: 4.h,
          margin: REdgeInsets.symmetric(
            vertical: 8,
          ),
        ),
        _Section(
          title: 'Design Size',
          child: _KeyValue(
            label: 'Base Size',
            value:
                '${AppDesign.designSize.width.toInt()} × ${AppDesign.designSize.height.toInt()}',
          ),
        ),
        _Section(
          title: 'Padding',
          child: Column(
            children: [
              const _KeyValue(
                label: 'Horizontal Padding',
                value: '${AppDesign.horizontalPadding}px',
              ),
              const _KeyValue(
                label: 'Vertical Padding',
                value: '${AppDesign.verticalPadding}px',
              ),
              _PaddingPreview(),
            ],
          ),
        ),
        _Section(
          title: 'Border Radius',
          child: Row(
            children: [
              _RadiusPreview(
                label: 'Default',
                radius: AppDesign.radius,
              ),
              SizedBox(width: 16.w),
              _RadiusPreview(
                label: 'Large',
                radius: AppDesign.radiusLarge,
              ),
            ],
          ),
        ),
        _Section(
          title: 'Heights',
          child: Column(
            children: [
              _HeightPreview('Input', AppDesign.inputHeight),
              _HeightPreview('Button', AppDesign.buttonHeight),
              _HeightPreview('AppBar', AppDesign.appBarHeight),
              _HeightPreview('Bottom Nav', AppDesign.bottomNavHeight),
            ],
          ),
        ),
        _Section(
          title: 'Sizes',
          child: Row(
            children: [
              _SizePreview('Icon', AppDesign.icon),
              SizedBox(width: 24.w),
              _SizePreview('Avatar', AppDesign.avatar),
            ],
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: tt.titleLarge),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}

class _KeyValue extends StatelessWidget {
  final String label;
  final String value;

  const _KeyValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(child: Text(label, style: tt.bodyMedium)),
          Text(
            value,
            style: tt.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SizePreview extends StatelessWidget {
  final String label;
  final double size;

  const _SizePreview(this.label, this.size);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.2),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          '$label (${size.toStringAsFixed(0)}px)',
          style: tt.bodySmall,
        ),
      ],
    );
  }
}

class _HeightPreview extends StatelessWidget {
  final String label;
  final double height;

  const _HeightPreview(this.label, this.height);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          SizedBox(
            height: height,
            width: 120.w,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: AppDesign.radius,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            '$label (${height.toStringAsFixed(0)}px)',
            style: tt.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _RadiusPreview extends StatelessWidget {
  final String label;
  final BorderRadius radius;

  const _RadiusPreview({
    required this.label,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 80,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: radius,
            border: Border.all(color: AppColors.border),
          ),
        ),
        SizedBox(height: 6.h),
        Text(label, style: tt.bodySmall),
      ],
    );
  }
}

class _PaddingPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: AppDesign.horizontalPadding.w,
        vertical: AppDesign.verticalPadding.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppDesign.radius,
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        'Padding Preview',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
