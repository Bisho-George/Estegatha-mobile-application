import 'package:estegatha/features/landing/presentation/widgets/custom_page_view.dart';
import 'package:estegatha/features/safty/data/api/fitness_connect_api.dart';
import 'package:estegatha/features/safty/domain/model/health_welcome_model.dart';
import 'package:estegatha/features/safty/presentation/pages/health_tracker_connect_page.dart';
import 'package:estegatha/features/safty/presentation/pages/health_tracker_data_page.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';

import '../widgets/health_welcome_widget.dart';

class HealthTrackerWelcomePage extends StatelessWidget {
  HealthTrackerWelcomePage({super.key});

  PageController pageController = PageController();
  PagesInfo pagesInfo = PagesInfo();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Health Tracker'),
      body: CustomPageView(
        itemCount: healthWelcomeModelList.length,
        itemBuilder: (context, index) {
          return HealthWelcomeWidget(
            healthWelcomeModel: healthWelcomeModelList[index],
          );
        },
        pageController: pageController,
        pagesInfo: pagesInfo,
        height: responsiveHeight(500),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: responsiveHeight(20)),
        child: FloatingActionButton(
          onPressed: () async{
            if(pagesInfo.isLastPage){
              if(await FitnessConnectApi().hasPermissions()){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HealthTrackerDataPage()));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HealthTrackerConnectPage()));
              }
            }
            else{
              pageController.nextPage(
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut);
            }
          },
          shape: const CircleBorder(),
          backgroundColor: ConstantColors.primary,
          child: const Icon(
            Icons.arrow_forward,
            color: ConstantColors.white,
          ),
        ),
      ),
    );
  }
}
