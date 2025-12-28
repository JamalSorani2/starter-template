I want to generate a Flutter starter dashboard app with the following requirements:

1. **Project Structure**:
   - `lib/common/presentation/ui/theme/` for theme, colors, sizes, and constants.
   - `lib/common/presentation/ui/widgets/` for reusable widgets: buttons, forms, dialogs, bottom sheets, cards.

2. **Theme and Colors**:
   - Centralized colors file (`app_colors.dart`) with primary, secondary, accent, background, and text colors and others.
   - `theme.dart` to define `ThemeData` using these colors.
   - App theme should be easily changeable and reflect changes with hot reload.

3. **Reusable Widgets**:
   - CustomButton, CustomTextField, CustomDialog, CustomBottomSheet, CustomCard.
   - Widgets should use the central theme/colors.

4. **Real-time Updates**:
   - Use a state management solution (Provider, Riverpod, or GetX) to allow updating theme/colors dynamically.
   - Any change in theme or widget style should be visible without hot restart.

5. **Responsive Design**:
   - Use responsive sizes based on Figma designs (`app_sizes.dart`).

6. **Dashboard Features**:
   - Basic dashboard layout with panels/cards.
   - Include placeholders for charts or lists.
   - Widgets should be easily reusable in any new screen.

7. **Extra**:
   - Include comments explaining how to change colors, fonts, and sizes.
   - Use best practices for a starter template.
   - seperate the code to many files in dashboard folder.

Generate the full Flutter project code with this structure so I can open it in VS Code and start building apps by just changing configs and widgets.
