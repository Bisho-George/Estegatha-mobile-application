import 'package:estegatha/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/health.dart';

import '../../../../utils/common/widgets/custom_app_bar.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../widgets/health_metrices_widget.dart';
import '../widgets/heart_rate_widget.dart';

class HealthTrackerDataPage extends StatelessWidget {
  const HealthTrackerDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Health Tracker',
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              GoogleSignInAccount ?account = GoogleSignIn().currentUser;
              HelperFunctions.showSnackBar(
              context, account!.displayName ?? '');
            },
            color: ConstantColors.primary,
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {

            },
            color: ConstantColors.primary,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HeartRateWidget(
                  heartRate: '82',
                  quality: 80,
                ),
                HealthMetricesWidget(
                  type: 'Blood Pressure',
                  value: '120/80',
                  unit: 'mm Hg',
                ),
                HealthMetricesWidget(
                  type: 'Blood Oxygen',
                  value: '98',
                  unit: '%',
                ),
                HealthMetricesWidget(
                  type: 'Temperature',
                  value: '36.5',
                  unit: '°C',
                ),
              ],
            ),
          ),
          Positioned(
            child: SvgPicture.asset('assets/character_track.svg'),
            bottom: responsiveHeight(120),
            right: responsiveWidth(20),
          ),
        ],
      ),
    );
  }
}
