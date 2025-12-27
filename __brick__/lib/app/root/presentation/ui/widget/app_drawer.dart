// import '../../../../../common/constant/app_string.dart';
// import '../../../../../common/imports/imports.dart';
// import '../../../../about_app/about_app.dart';
// import '../../../../contact_us/presentation/ui/screen/contact_us.dart';
// import '../../../../profile/presentation/ui/screen/profile_screen.dart';

// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(top: 20.h),
//             child: Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     context.router.pushNamed(AboutAppScreen.routePath);
//                   },
//                   child: const Text(AppString.whoUs),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.router.pushNamed(ProfileScreen.pagePath);
//                   },
//                   child: const Text(AppString.profile),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.router.pushNamed(ContactUs.pagePath);
//                   },
//                   child: const Text(AppString.contactUs),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
