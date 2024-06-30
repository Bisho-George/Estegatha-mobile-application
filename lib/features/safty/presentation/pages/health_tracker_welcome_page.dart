import 'package:estegatha/features/landing/presentation/widgets/custom_page_view.dart';
import 'package:estegatha/features/safty/domain/model/health_welcome_model.dart';
import 'package:estegatha/features/safty/presentation/pages/health_tracker_connect_page.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/health_welcome_widget.dart';

class HealthTrackerWelcomePage extends StatelessWidget {
  HealthTrackerWelcomePage({super.key});
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: responsiveHeight(77),
            right: responsiveWidth(55),
            child: GestureDetector(
              onTap: () {
                if(pageController.page?.round() == healthWelcomeModelList.length - 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HealthTrackerConnectPage()));
                }
                else{
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.easeInOut);
                }
              },
              child: const CircleAvatar(
                backgroundColor: ConstantColors.primary,
                radius: 28,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
          ),
          CustomPageView(
            itemCount: healthWelcomeModelList.length,
            itemBuilder: (context, index) {
              return HealthWelcomeWidget(
                healthWelcomeModel: healthWelcomeModelList[index],
              );
            },
            pageController: pageController,
            height: responsiveHeight(700),
          ),
        ],
      ),
    );
  }
}
