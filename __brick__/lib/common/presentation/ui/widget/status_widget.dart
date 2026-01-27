import '../../../imports/imports.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, required this.color, required this.name});
  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppDesign.radius,
      ),
      child: Text(
        name,
        style: context.bodySmall.copyWith(color: Colors.white),
      ),
    );
  }
}
