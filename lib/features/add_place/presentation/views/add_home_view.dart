
import 'package:estegatha/features/add_place/presentation/views/widgets/custom_google_maps.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';

class AddHomeView extends StatelessWidget {
  static const String routeName = '/add_home';

  const AddHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add home',
            style: TextStyle(
              color: ConstantColors.primary,
              fontSize: ConstantSizes.fontSizeLg,
              fontWeight: ConstantSizes.fontWeightRegular,
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Save')),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.2,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.all(
              ConstantSizes.defaultSpace,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.bookmark,
                              color: Colors.grey[400],
                            ),
                            hintText: "Place type",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: ConstantSizes.defaultSpace),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              FontAwesomeIcons.locationDot,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: CustomGoogleMaps()),
        ],
      ),
    );
  }
}


