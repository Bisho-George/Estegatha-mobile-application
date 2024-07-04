import 'package:estegatha/features/safty/data/api/fitness_connect_api.dart';
import 'package:estegatha/features/safty/presentation/pages/health_tracker_data_page.dart';
import 'package:estegatha/features/safty/presentation/widgets/sign_in_google_widget.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/common/widgets/custom_app_bar.dart';

class HealthTrackerConnectPage extends StatelessWidget {
  const HealthTrackerConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Health Tracker'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(ConstantImages.healthTrackerImage3),
              width: double.infinity,
              height: responsiveHeight(400),
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: responsiveHeight(100),
            ),
            SignInGoogleWidget(
              onTap: () async{
/*                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HealthTrackerDataPage(),
                  ),
                );*/
/*                List<BloodGlucose> g = await FitnessConnectApi().connect();
                for(var a in g){
                  print(a);
                }*/
              },
            ),
          ],
        ),
      ),
    );
  }
}
