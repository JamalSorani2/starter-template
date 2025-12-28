import '/common/imports/imports.dart';

class ShadowThemeShowcase extends StatelessWidget {
  const ShadowThemeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final shadows = <_ShadowItem>[
      _ShadowItem('Card (Elevation 1)', AppShadows.card),
      _ShadowItem('Medium (Elevation 2)', AppShadows.md),
      _ShadowItem('Large (Elevation 3)', AppShadows.lg),
      _ShadowItem('Soft', AppShadows.soft),
      _ShadowItem(
        'Glow (Primary)',
        AppShadows.glow(AppColors.primary),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shadow Theme Showcase',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        CustomDivider(
          height: 4.h,
          margin: REdgeInsets.symmetric(vertical: 8),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: shadows.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = shadows[index];
            return _ShadowTile(item: item);
          },
        ),
      ],
    );
  }
}

class _ShadowTile extends StatelessWidget {
  final _ShadowItem item;

  const _ShadowTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        // Shadow preview
        Container(
          width: 64,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: item.shadows,
          ),
        ),
        SizedBox(width: 12.w),

        // Name + info
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

class _ShadowItem {
  final String name;
  final List<BoxShadow> shadows;

  _ShadowItem(this.name, this.shadows);

  String get description {
    final s = shadows.first;

    final blur = s.blurRadius.toStringAsFixed(0);
    final spread = s.spreadRadius.toStringAsFixed(0);
    final dx = s.offset.dx.toStringAsFixed(0);
    final dy = s.offset.dy.toStringAsFixed(0);

    return 'Blur $blur • Spread $spread • Offset ($dx, $dy)';
  }
}
