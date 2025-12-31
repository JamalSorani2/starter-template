import '/common/imports/imports.dart';

class ColorThemeShowcase extends StatelessWidget {
  const ColorThemeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = <_ColorItem>[
      // Brand
      _ColorItem('Primary', AppColors.primary),
      _ColorItem('Secondary', AppColors.secondary),
      _ColorItem('On Secondary', AppColors.onSecondary),

      // Backgrounds
      _ColorItem('Surface', AppColors.surface),
      _ColorItem('Card', AppColors.card),

      // Text
      _ColorItem('Text Primary', AppColors.textPrimary),
      _ColorItem('Text Secondary', AppColors.textSecondary),
      _ColorItem('Text Disabled', AppColors.textDisabled),

      // Status
      _ColorItem('Success', AppColors.success),
      _ColorItem('Warning', AppColors.warning),
      _ColorItem('Danger', AppColors.danger),
      _ColorItem('Info', AppColors.info),
      _ColorItem('Grey', AppColors.grey),

      // Borders & overlay
      _ColorItem('Border', AppColors.border),
      _ColorItem('Overlay', AppColors.overlay),
      _ColorItem('Shadow', AppColors.shadow),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Theme Showcase',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        CustomDivider(
          height: 4.h,
          margin: REdgeInsets.symmetric(
            vertical: 8,
          ),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: colors.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = colors[index];
            return _ColorTile(item: item);
          },
        ),
      ],
    );
  }
}

class _ColorTile extends StatelessWidget {
  final _ColorItem item;

  const _ColorTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        // Color box
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.border),
          ),
        ),
        SizedBox(width: 12.w),

        // Name + hex
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: tt.titleMedium),
              Text(
                item.hex,
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

class _ColorItem {
  final String name;
  final Color color;

  _ColorItem(this.name, this.color);

  String get hex =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
