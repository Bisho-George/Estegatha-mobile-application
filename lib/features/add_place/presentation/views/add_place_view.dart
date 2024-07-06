import 'package:estegatha/features/add_place/presentation/views/widgets/place_option.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/constant/colors.dart';

class AddPlaceView extends StatelessWidget {
  static const String routeName = '/add_place';

  const AddPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Places',
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
        body: const Column(
          children: [
            PlaceOption(
              optionText: "Add a new Place",
              icon: Icons.add,
              iconSize: 30,
            ),
            PlaceOption(
              optionText: "Edit your Home",
              icon: FontAwesomeIcons.houseChimney,
              iconColor: ConstantColors.primary,
              iconSize: 26,
              backgroundColor: ConstantColors.white,
              borderColor: ConstantColors.secondaryBackground,
            ),
            PlaceOption(
              optionText: "Add your School",
              icon: FontAwesomeIcons.graduationCap,
              iconSize: 26,
            ),
            PlaceOption(
              optionText: "Add your Work",
              icon: FontAwesomeIcons.briefcase,
              iconSize: 30,
            ),
            PlaceOption(
              optionText: "Add your Store",
              icon: FontAwesomeIcons.cartShopping,
              iconSize: 26,
            ),
          ],
        ));
  }
}
