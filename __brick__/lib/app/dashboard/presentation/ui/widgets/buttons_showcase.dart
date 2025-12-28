import '/common/imports/imports.dart';

class ButtonsShowcase extends StatefulWidget {
  const ButtonsShowcase({super.key});

  @override
  State<ButtonsShowcase> createState() => _ButtonsShowcaseState();
}

class _ButtonsShowcaseState extends State<ButtonsShowcase> {
  bool _loading = false;
  bool _disabled = false;
  bool _switchValue = true;
  bool _toggleValue = false;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Buttons Showcase', style: tt.displayLarge),
        CustomDivider(height: 4.h, margin: REdgeInsets.symmetric(vertical: 8)),

        // Primary variations
        CustomCard(
          header: Text('Primary Buttons', style: tt.titleLarge),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              CustomButton.primary(
                text: 'Primary',
                onPressed: _disabled
                    ? null
                    : () => BotToast.showText(text: 'Primary pressed'),
                isLoading: _loading,
              ),
              CustomButton.secondary(
                text: 'Secondary',
                onPressed: _disabled
                    ? null
                    : () => BotToast.showText(text: 'Secondary pressed'),
                isLoading: _loading,
              ),
              CustomButton.danger(
                text: 'Danger',
                onPressed: _disabled
                    ? null
                    : () => BotToast.showText(text: 'Danger pressed'),
                isLoading: _loading,
              ),
              CustomButton.outlined(
                text: 'Outlined',
                onPressed: _disabled
                    ? null
                    : () => BotToast.showText(text: 'Outlined pressed'),
                isLoading: _loading,
              ),
              CustomButton.primaryText(
                text: 'Text Button',
                onPressed: _disabled
                    ? null
                    : () => BotToast.showText(text: 'Text pressed'),
                isLoading: _loading,
              ),
            ],
          ),
        ),
        16.verticalSpace,

        // Icon buttons
        CustomCard(
          header: Text('Icon Buttons', style: tt.titleLarge),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Row(),
              CopyButton(text: 'Copy me'),
              ShareButton(
                message: 'Check out this app!',
              ),
              DeleteButton(onTap: nullOk, isLoading: false),
            ],
          ),
        ),
        16.verticalSpace,

        // Toggles
        CustomCard(
          header: Text('Toggles & Switches', style: tt.titleLarge),
          child: Wrap(
            spacing: 16.w,
            runSpacing: 12.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Row(),
              CustomSwitch(
                label: 'Switch',
                value: _switchValue,
                onChanged: (v) => setState(() => _switchValue = v),
              ),
              CustomToggle(
                label: 'Toggle',
                value: _toggleValue,
                onChanged: (v) => setState(() => _toggleValue = v),
              ),
            ],
          ),
        ),
        16.verticalSpace,

        // Navigation helpers
        CustomCard(
          header: Text('Navigation Buttons', style: tt.titleLarge),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: const [
              Row(),
              CustomBackButton(),
              CustomDrawerButton(),
            ],
          ),
        ),
        16.verticalSpace,

        // Controls
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _loading = !_loading),
                icon: Icon(_loading ? Icons.stop : Icons.play_arrow),
                label: Text(_loading ? 'Stop Loading' : 'Start Loading'),
              ),
              ElevatedButton.icon(
                onPressed: () => setState(() => _disabled = !_disabled),
                icon: Icon(_disabled ? Icons.lock : Icons.lock_open),
                label: Text(_disabled ? 'Enable Buttons' : 'Disable Buttons'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Helper to avoid null callbacks in const context for DeleteButton demo
void nullOk() {}
