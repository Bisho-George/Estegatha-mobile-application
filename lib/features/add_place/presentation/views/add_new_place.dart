import 'package:estegatha/features/add_place/presentation/views/widgets/place_option.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';

class AddNewPlaceView extends StatelessWidget {
  static const String routeName = '/add_new_place';
  const AddNewPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add a new Place',
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
        ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.15,
            decoration: const BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: ConstantColors.grey,
                  width: 1,
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(ConstantSizes.defaultSpace, ConstantSizes.defaultSpace, ConstantSizes.defaultSpace,
            ConstantSizes.defaultSpace * 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: "Search address or location na...",
                         hintStyle: TextStyle(
                        color: ConstantColors.darkGrey,
                        fontSize: ConstantSizes.fontSizeMd,
                        fontWeight: ConstantSizes.fontWeightRegular,
                      ),
                    ),


                  ),
                ),
              ],
            ),
          ),
          const PlaceOption(optionText: "Locate on Map", icon: FontAwesomeIcons.mapLocationDot, iconSize: 26, iconColor: ConstantColors.secondaryBackground,
          backgroundColor: ConstantColors.white, borderColor: ConstantColors.grey),
          Container(
            decoration:  BoxDecoration(
              color: Colors.grey[100],
            ),
            padding: const EdgeInsets.all(
              ConstantSizes.spaceBtwItems
            ),
            child: Row(
              children: [
                Text(
                  "Nearby locations",
                  style:  TextStyle(
                    fontSize: ConstantSizes.fontSizeMd,
                    fontWeight: ConstantSizes.fontWeightBold,
                    color: Colors.grey[500]
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(3, (index) => PlaceOption(
            optionText: "Nearby location $index",
            icon: FontAwesomeIcons.mapLocationDot,
            iconSize: 26,
            iconColor: ConstantColors.secondaryBackground,
            backgroundColor: ConstantColors.white,
            borderColor: ConstantColors.grey,
          ))
        ]
      ),
    );
  }
}
