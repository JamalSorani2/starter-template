import '/common/imports/imports.dart';

class TextThemeShowcase extends StatelessWidget {
  const TextThemeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    final entries = <_Item>[
      _Item('displayLarge', tt.displayLarge!),
      _Item('displayMedium', tt.displayMedium!),
      _Item('displaySmall', tt.displaySmall!),
      _Item('headlineLarge', tt.headlineLarge!),
      _Item('headlineMedium', tt.headlineMedium!),
      _Item('headlineSmall', tt.headlineSmall!),
      _Item('titleLarge', tt.titleLarge!),
      _Item('titleMedium', tt.titleMedium!),
      _Item('titleSmall', tt.titleSmall!),
      _Item('bodyLarge', tt.bodyLarge!),
      _Item('bodyMedium', tt.bodyMedium!),
      _Item('bodySmall', tt.bodySmall!),
      _Item('labelLarge', tt.labelLarge!),
      _Item('labelMedium', tt.labelMedium!),
      _Item('labelSmall', tt.labelSmall!),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Text Theme Showcase",
          style: tt.displayLarge,
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
          padding: EdgeInsets.zero,
          itemCount: entries.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final e = entries[i];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.name, style: e.style),
                Text(
                  "Font Size: ${e.style.fontSize}, Weight: ${e.style.fontWeight?.toString() ?? 'normal'}",
                  style: e.style,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Item {
  final String name;
  final TextStyle style;
  _Item(this.name, this.style);
}
