import '/common/imports/imports.dart';

class GradientThemeShowcase extends StatelessWidget {
  const GradientThemeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final gradients = <_GradientItem>[
      _GradientItem('Primary', AppGradients.primary),
      _GradientItem('Secondary', AppGradients.secondary),
      _GradientItem('Background', AppGradients.background),
      _GradientItem('Overlay', AppGradients.overlay),
      _GradientItem('Success', AppGradients.success),
      _GradientItem('Warning', AppGradients.warning),
      _GradientItem('Danger', AppGradients.danger),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gradient Theme Showcase',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        CustomDivider(
          height: 4.h,
          margin: REdgeInsets.symmetric(vertical: 8),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: gradients.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = gradients[index];
            return _GradientTile(item: item);
          },
        ),
      ],
    );
  }
}

class _GradientTile extends StatelessWidget {
  final _GradientItem item;

  const _GradientTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        // Gradient box
        Container(
          width: 64,
          height: 48,
          decoration: BoxDecoration(
            gradient: item.gradient,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.border),
          ),
        ),
        SizedBox(width: 12.w),

        // Name + details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: tt.titleMedium),
              Text(
                item.description,
                style: tt.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GradientItem {
  final String name;
  final LinearGradient gradient;

  _GradientItem(this.name, this.gradient);

  String get description {
    final begin = _alignmentToString(gradient.begin);
    final end = _alignmentToString(gradient.end);
    return 'Linear • $begin → $end';
  }

  String _alignmentToString(AlignmentGeometry a) {
    if (a == Alignment.topLeft) {
      return 'TopLeft';
    }
    if (a == Alignment.topCenter) {
      return 'TopCenter';
    }
    if (a == Alignment.topRight) {
      return 'TopRight';
    }
    if (a == Alignment.centerLeft) {
      return 'CenterLeft';
    }
    if (a == Alignment.center) {
      return 'Center';
    }
    if (a == Alignment.centerRight) {
      return 'CenterRight';
    }
    if (a == Alignment.bottomLeft) {
      return 'BottomLeft';
    }
    if (a == Alignment.bottomCenter) {
      return 'BottomCenter';
    }
    if (a == Alignment.bottomRight) {
      return 'BottomRight';
    }
    return 'Custom';
  }
}
