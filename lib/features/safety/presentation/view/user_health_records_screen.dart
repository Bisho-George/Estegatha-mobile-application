import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/settings_card_carousel.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/organization_app_bar.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/organization_tab_status.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/safety/presentation/view/add_health_record_screen.dart';
import 'package:estegatha/features/safety/presentation/view/widgets/user_health_record_list.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';

import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserHealthRecordScreen extends StatelessWidget {
  const UserHealthRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIcon: Icons.arrow_back,
          leadingOnPressed: () {
            Navigator.pop(context, true);
          },
          title: Text(
            "Health Records",
            style: TextStyle(
              fontSize: SizeConfig.font20,
              color: ConstantColors.primary,
            ),
          ),
          showBackArrow: false,
        ),
        body: Column(
          children: [
            SettingCardCarousel(
              helpNotes: ConstantVariables.userHealthRecordsNotes,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(ConstantSizes.md),
                vertical: getProportionateScreenHeight(ConstantSizes.md),
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ConstantColors.borderSecondary,
                    width: 1,
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddHealthRecordScreen(),
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: getProportionateScreenWidth(40),
                      height: getProportionateScreenHeight(40),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ConstantColors.grey),
                      ),
                      child:
                          const Icon(Icons.add, color: ConstantColors.primary),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(ConstantSizes.md),
                    ),
                    Text(
                      "Add Health Record",
                      style: TextStyle(
                        fontSize: SizeConfig.font20,
                        fontWeight: FontWeight.w900,
                        color: ConstantColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SectionHeading(title: "Your Health Records"),
            const TabBar(
              tabs: [
                Tab(text: "Diseases"),
                Tab(text: "Medicines"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // First tab content => Track location
                  ListView(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: ConstantSizes.bottomNavBarHeight),
                          child: UserHealthRecordList(
                            recordType: ConstantVariables.diseaseType,
                          ),
                        ),
                      )
                    ],
                  ),

                  ListView(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: ConstantSizes.bottomNavBarHeight),
                          child: UserHealthRecordList(
                            recordType: ConstantVariables.medicineType,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // return Scaffold(
  //   appBar: CustomAppBar(
  //     leadingIcon: Icons.arrow_back,
  //     leadingOnPressed: () {
  //       Navigator.pop(context, true);
  //     },
  //     title: Text(
  //       "Health Records",
  //       style: TextStyle(
  //         fontSize: SizeConfig.font20,
  //         color: ConstantColors.primary,
  //       ),
  //     ),
  //     showBackArrow: false,
  //   ),
  //   body: Padding(
  //     padding:
  //         const EdgeInsets.only(bottom: ConstantSizes.bottomNavBarHeight),
  //     child: Column(
  //       children: <Widget>[
  //         SettingCardCarousel(
  //           helpNotes: ConstantVariables.userHealthRecordsNotes,
  //         ),
  //         Container(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: getProportionateScreenWidth(ConstantSizes.md),
  //             vertical: getProportionateScreenHeight(ConstantSizes.md),
  //           ),
  //           decoration: const BoxDecoration(
  //             border: Border(
  //               bottom: BorderSide(
  //                 color: ConstantColors.borderSecondary,
  //                 width: 1,
  //               ),
  //             ),
  //           ),
  //           child: GestureDetector(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => const AddHealthRecordScreen(),
  //                 ),
  //               );
  //             },
  //             child: Row(
  //               children: <Widget>[
  //                 Container(
  //                   width: getProportionateScreenWidth(40),
  //                   height: getProportionateScreenHeight(40),
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     border: Border.all(color: ConstantColors.grey),
  //                   ),
  //                   child:
  //                       const Icon(Icons.add, color: ConstantColors.primary),
  //                 ),
  //                 SizedBox(
  //                   width: getProportionateScreenWidth(ConstantSizes.md),
  //                 ),
  //                 Text(
  //                   "Add Health Record",
  //                   style: TextStyle(
  //                     fontSize: SizeConfig.font20,
  //                     fontWeight: FontWeight.w900,
  //                     color: ConstantColors.primary,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         const SectionHeading(title: "Your Health Records"),
  //         const Expanded(
  //           child: SingleChildScrollView(
  //             child: UserHealthRecordList(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}
