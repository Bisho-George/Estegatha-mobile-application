// import 'package:estegatha/features/add_place/presentation/views/add_boundary_view.dart';
// import 'package:estegatha/features/add_place/presentation/views/add_new_boundary.dart';
// import 'package:estegatha/features/add_place/presentation/views/widgets/place_option.dart';
// import 'package:estegatha/utils/constant/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../../../../utils/constant/colors.dart';
//
// class AddBoundaryView extends StatelessWidget {
//   static const String routeName = '/add_place';
//
//   const AddBoundaryView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Boundaries',
//               style: TextStyle(
//                 color: ConstantColors.primary,
//                 fontSize: ConstantSizes.fontSizeLg,
//                 fontWeight: ConstantSizes.fontWeightRegular,
//               )),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, AddHomeView.routeName);
//               },
//               child: const PlaceOption(
//                 optionText: "Add a new boundary",
//                 icon: Icons.add,
//                 iconSize: 30,
//               ),
//             ),
//             // GestureDetector(
//             //   onTap: () {
//             //     Navigator.pushNamed(context, AddHomeView.routeName,
//             //         arguments: "home");
//             //   },
//             //   child: const PlaceOption(
//             //     optionText: "Edit your Home",
//             //     icon: FontAwesomeIcons.houseChimney,
//             //     iconColor: ConstantColors.primary,
//             //     iconSize: 26,
//             //     backgroundColor: ConstantColors.white,
//             //     borderColor: ConstantColors.secondaryBackground,
//             //   ),
//             // ),
//             // GestureDetector(
//             //   onTap: () {
//             //     Navigator.pushNamed(context, AddHomeView.routeName,
//             //         arguments: "school");
//             //   },
//             //   child: const PlaceOption(
//             //     optionText: "Add your School",
//             //     icon: FontAwesomeIcons.graduationCap,
//             //     iconSize: 26,
//             //   ),
//             // ),
//             // GestureDetector(
//             //   onTap: () {
//             //     Navigator.pushNamed(context, AddHomeView.routeName,
//             //         arguments: "work");
//             //   },
//             //   child: const PlaceOption(
//             //     optionText: "Add your Work",
//             //     icon: FontAwesomeIcons.briefcase,
//             //     iconSize: 30,
//             //   ),
//             // ),
//             // GestureDetector(
//             //   onTap: () {
//             //     Navigator.pushNamed(context, AddHomeView.routeName,
//             //         arguments: "store");
//             //   },
//             //   child: const PlaceOption(
//             //     optionText: "Add your Store",
//             //     icon: FontAwesomeIcons.cartShopping,
//             //     iconSize: 26,
//             //   ),
//             // ),
//           ],
//         ));
//   }
// }
