import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/category_header_widget.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/location_search_widget.dart';
class LocationFeedbackPage extends StatelessWidget {
  LocationFeedbackPage({super.key});
  static const String routeName = '/location-feedback';
  TextEditingController feedbackController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Location Feedback',
        actions: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: (){

            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(ConstantSizes.xl),
              vertical: responsiveHeight(ConstantSizes.md),
            ),
            child: LocationSearchWidget(locationController: locationController),
          ),
          SizedBox(
            height: responsiveHeight(ConstantSizes.md),
          ),
          const CategoryHeaderWidget(name: 'Quick access'),
          LocationQuickAccessWidget(
            title: 'Use my current location',
            iconPath: 'assets/current_location.png',
          ),
          LocationQuickAccessWidget(
            title: 'Locate on map',
            iconPath: 'assets/locate_icon.png',
          ),
          SizedBox(
            height: responsiveHeight(ConstantSizes.md),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(ConstantSizes.sm),
            ),
            child: TextField(
              controller: feedbackController,
              decoration: InputDecoration(
                hintText: 'Type your feedback here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class LocationQuickAccessWidget extends StatelessWidget {
  LocationQuickAccessWidget({
    super.key,
    required this.title,
    required this.iconPath
  });
  String title;
  String iconPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(ConstantSizes.xl),
        vertical: responsiveHeight(ConstantSizes.lg),
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ConstantColors.buttonDisabled,
            width: 1,
          ),
        )
      ),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(iconPath),
            color: ConstantColors.primary,
            size: 24,
          ),
          SizedBox(
            width: responsiveWidth(ConstantSizes.sm),
          ),
          Text(
            title,
            style: Styles.getDefaultPrimary(
              weight: ConstantSizes.fontWeightSemiBold,
              fontSize: ConstantSizes.fontSizeLg,
            ),
          ),
        ],
      ),
    );
  }
}


