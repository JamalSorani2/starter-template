import '../../../../imports/imports.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.text, this.isSearch = false});

  final String? text;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.search_off, size: 100.sp),
        12.verticalSpace,
        Text(
          text ?? (isSearch ? AppString.noResultsFound : AppString.noDataFound),
          style: context.headlineMedium.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
