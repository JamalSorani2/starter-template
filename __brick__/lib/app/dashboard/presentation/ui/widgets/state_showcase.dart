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
          child: Column(
            spacing: 16.w,
            children: [
              const Row(),
              ...LoadingType.values
                  .map(
                    (type) => Column(
                      children: [
                        SizedBox(
                          width: 80.r,
                          height: 80.r,
                          child: LoadingProgress(type: type),
                        ),
                        Text(type.name),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        16.verticalSpace,

        // No data
        CustomCard(
          header: Text('NoDataWidget', style: tt.titleLarge),
          child: const Column(
            children: [
              Row(),
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
