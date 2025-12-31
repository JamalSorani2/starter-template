import '../../../../../../common/imports/imports.dart';
import '../widgets/buttons_showcase.dart';
import '../widgets/chart_placeholder.dart';
import '../widgets/color_theme_showcase.dart';
import '../widgets/design_tokens_showcase.dart';
import '../widgets/forms_showcase.dart';
import '../widgets/gradient_showcase.dart';
import '../widgets/list_placeholder.dart';
import '../widgets/overlays_showcase.dart';
import '../widgets/responsive_grid.dart';
import '../widgets/shadow_theme_showcase.dart';
import '../widgets/state_showcase.dart';
import '../widgets/stats_card.dart';
import '../widgets/text_theme_showcase.dart';

/// DashboardScreen
/// A simple starter layout demonstrating reusable cards, placeholders,
/// and responsive grid behavior. Replace placeholders with real charts/lists.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: CloseKeyboardOntapOutside(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(
              title: 'Dashboard',
              actions: [
                Consumer<ThemeProvider>(
                  builder: (context, provider, _) {
                    final isLight = provider.themeMode != ThemeMode.dark;
                    return Row(
                      children: [
                        Icon(
                          isLight ? Icons.light_mode : Icons.dark_mode,
                          color: AppColors.textSecondary,
                        ),
                        4.horizontalSpace,
                        Switch(
                          value: isLight,
                          onChanged: (_) => provider.toggleTheme(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: REdgeInsets.symmetric(
                  horizontal: AppDesign.horizontalPadding,
                ),
                child: Column(
                  children: [
                    16.verticalSpace,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const TextThemeShowcase(),
                            32.verticalSpace,
                            const ColorThemeShowcase(),
                            32.verticalSpace,
                            const GradientThemeShowcase(),
                            32.verticalSpace,
                            const DesignTokensShowcase(),
                            32.verticalSpace,
                            const ShadowThemeShowcase(),
                            32.verticalSpace,
                            const FormsShowcase(),
                            32.verticalSpace,
                            const ButtonsShowcase(),
                            32.verticalSpace,
                            const OverlaysShowcase(),
                            32.verticalSpace,
                            const StateShowcase(),
                            32.verticalSpace,
                            const ResponsiveGrid(
                              children: [
                                StatsCard(
                                  title: 'Users',
                                  value: '1,204',
                                  icon: Icons.people,
                                ),
                                StatsCard(
                                  title: 'Revenue',
                                  value: '45,230',
                                  icon: Icons.attach_money,
                                ),
                                StatsCard(
                                  title: 'Orders',
                                  value: '342',
                                  icon: Icons.shopping_bag,
                                ),
                                StatsCard(
                                  title: 'Tickets',
                                  value: '27',
                                  icon: Icons.support_agent,
                                ),
                              ],
                            ),
                            16.verticalSpace,
                            const ResponsiveGrid(
                              children: [
                                ChartPlaceholder(title: 'Sales (Placeholder)'),
                                ListPlaceholder(
                                  title: 'Recent Activity (Placeholder)',
                                ),
                              ],
                            ),
                            32.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
