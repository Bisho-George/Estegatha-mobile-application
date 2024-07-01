import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/organization_setting_item.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/settings_card_carousel.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/safety/presentation/view/add_health_record_screen.dart';
import 'package:estegatha/features/safety/presentation/view_model/user_health_cubit.dart';
import 'package:estegatha/features/safty/presentation/pages/emergency_contact_page.dart';
import 'package:estegatha/features/safty/presentation/pages/health_tracker_welcome_page.dart';
import 'package:estegatha/features/safty/presentation/pages/location_feedback_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';

import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/safty_item_widget.dart';

class SafetyScreen extends StatelessWidget {
  SafetyScreen({super.key, this.parentContext});
  static String routeName = "/safety";
  BuildContext ?parentContext;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Safety',
          style: TextStyle(
            color: ConstantColors.textPrimary,
            fontSize: getProportionateScreenHeight(SizeConfig.font20),
          ),
        ),
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                getProportionateScreenHeight(ConstantSizes.bottomNavBarHeight),
          ),
          child: Column(
            children: <Widget>[
              SafetyItemWidget(
                label: "Health Records",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserHealthRecordScreen()));
                },
                icon: Icons.event_note_sharp,
              ),
              SafetyItemWidget(
                label: "Emergency Contact",
                onTap: () {
                  Navigator.of(parentContext ?? context).push(MaterialPageRoute(
                      builder: (context) => EmergencyContactPage()));
                },
                icon: Icons.contact_phone,
              ),
              SafetyItemWidget(
                label: "Health Track",
                onTap: () {
                  Navigator.of(parentContext ?? context).push(MaterialPageRoute(
                      builder: (context) => HealthTrackerWelcomePage()));
                },
                icon: Icons.watch,
              ),
              SafetyItemWidget(
                label: "Emergency Catalog",
                onTap: () {},
                icon: Icons.list_alt,
              ),
              SafetyItemWidget(
                label: "Location Feedback",
                onTap: () {
                  Navigator.of(parentContext ?? context).push(MaterialPageRoute(
                      builder: (context) => LocationFeedbackPage()));
                },
                icon: Icons.edit_location_alt_sharp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserHealthRecordScreen extends StatelessWidget {
  const UserHealthRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: ConstantSizes.bottomNavBarHeight),
        child: Column(
          children: <Widget>[
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
            const Expanded(
              child: SingleChildScrollView(
                child: UserHealthRecordList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserHealthRecordList extends StatefulWidget {
  const UserHealthRecordList({super.key});

  @override
  _UserHealthRecordListState createState() => _UserHealthRecordListState();
}

class _UserHealthRecordListState extends State<UserHealthRecordList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserHealthCubit>(context, listen: false)
        .getUserHealthInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHealthCubit, UserHealthState>(
      builder: (context, state) {
        print("State: $state");
        if (state is UserHealthInfoLoaded) {
          print("Illnesses: ${state.userHealthInfo.illnesses}");
          final illnesses = state.userHealthInfo.illnesses;
          final medicines = state.userHealthInfo.medicines;

          return Column(
            children: illnesses!.map((record) {
              return HealthRecordCard(
                date: 'Monday, 27 March 2023', // TODO: Replace with actual date
                chronicDisease: record,
                onTapAddNotes: () {
                  // Handle add notes functionality
                },
                onTapDeleteRecord: () {
                  // Handle delete record functionality
                },
              );
            }).toList(),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: ConstantSizes.defaultSpace),
            child: Center(child: Loader()),
          );
        }
      },
    );
  }
}

class HealthRecordCard extends StatelessWidget {
  final String date;
  final String chronicDisease;
  final VoidCallback onTapAddNotes;
  final VoidCallback onTapDeleteRecord;

  const HealthRecordCard({
    Key? key,
    required this.date,
    required this.chronicDisease,
    required this.onTapAddNotes,
    required this.onTapDeleteRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(ConstantSizes.md),
        vertical: getProportionateScreenHeight(ConstantSizes.sm),
      ),
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(ConstantSizes.md)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
            child: Text(
              date,
              style: TextStyle(
                color: ConstantColors.textSecondary,
                fontSize: SizeConfig.font14,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(ConstantSizes.xs)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
            child: Text(
              "Chronic disease: $chronicDisease",
              style: TextStyle(
                color: ConstantColors.primary,
                fontSize: SizeConfig.font18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(ConstantSizes.md)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // GestureDetector(
                //   onTap: onTapAddNotes,
                //   child: Row(
                //     children: [
                //       Icon(Icons.add, color: ConstantColors.primary),
                //       SizedBox(
                //           width: getProportionateScreenWidth(ConstantSizes.xs)),
                //       Text(
                //         "Add Notes",
                //         style: TextStyle(
                //           color: ConstantColors.primary,
                //           fontSize: SizeConfig.font16,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                GestureDetector(
                  onTap: onTapDeleteRecord,
                  child: Text(
                    "Delete record",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: SizeConfig.font16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: getProportionateScreenHeight(ConstantSizes.sm)),
          // const SectionHeading(title: "Notes:"),
          // SizedBox(height: getProportionateScreenHeight(ConstantSizes.sm)),
          // Center(
          //   child: Column(
          //     children: [
          //       Image.asset(
          //         'assets/no_health_record_note.png',
          //         height: getProportionateScreenHeight(100),
          //       ),
          //       SizedBox(
          //           height: getProportionateScreenHeight(ConstantSizes.sm)),
          //       Text(
          //         "No Notes yet!",
          //         style: TextStyle(
          //           color: ConstantColors.textSecondary,
          //           fontSize: SizeConfig.font14,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
