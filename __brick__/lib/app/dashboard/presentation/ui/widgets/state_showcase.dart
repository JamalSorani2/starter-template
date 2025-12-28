import '/common/imports/imports.dart';

class StateShowcase extends StatelessWidget {
  const StateShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('State Widgets Showcase', style: tt.displayLarge),
        CustomDivider(height: 4.h, margin: REdgeInsets.symmetric(vertical: 8)),

        // Loading
        CustomCard(
          header: Text('LoadingProgress', style: tt.titleLarge),
          child: Wrap(
            spacing: 16.w,
            runSpacing: 35.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              LoadingProgress(),
              LoadingProgress(type: LoadingType.doubleBounce),
              LoadingProgress(type: LoadingType.rotatingCircle),
              LoadingProgress(type: LoadingType.wave),
              LoadingProgress(type: LoadingType.chasingDots),
              LoadingProgress(type: LoadingType.threeBounce),
              LoadingProgress(type: LoadingType.foldingCube),
              LoadingProgress(type: LoadingType.pulsingGrid),
            ],
          ),
        ),
        16.verticalSpace,

        // No data
        CustomCard(
          header: Text('NoDataWidget', style: tt.titleLarge),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoDataWidget(),
              SizedBox(height: 16),
              NoDataWidget(isSearch: true),
            ],
          ),
        ),
        16.verticalSpace,

        // Failure
        CustomCard(
          header: Text('FailureWidget', style: tt.titleLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FailureWidget(
                message: 'Could not fetch data from server',
                onRetry: () async {
                  BotToast.showText(text: 'Retry tapped');
                  await Future.delayed(const Duration(milliseconds: 500));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
