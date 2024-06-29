import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view/setting/widgets/organization_setting_item.dart';
import 'package:estegatha/features/safety/presentation/view/user_health_records_screen.dart';
import 'package:estegatha/features/safety/presentation/view_model/user_health_cubit.dart';
import 'package:estegatha/features/safty/presentation/pages/emergency_contact_page.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';

import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

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
              OrganizationSettingItem(
                label: "Health Records",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserHealthRecordScreen()));
                },
              ),
              OrganizationSettingItem(
                label: "Emergency Contact",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EmergencyContactPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
