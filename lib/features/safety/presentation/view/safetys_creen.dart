import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/organization_setting_item.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/settings_card_carousel.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/safety/presentation/view/add_health_record_screen.dart';
import 'package:estegatha/features/safety/presentation/view/user_health_records_screen.dart';
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
