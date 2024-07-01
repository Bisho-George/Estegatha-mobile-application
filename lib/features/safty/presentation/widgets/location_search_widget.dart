import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';

class LocationSearchWidget extends StatelessWidget {
  const LocationSearchWidget({
    super.key,
    required this.locationController,
  });

  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding:
          EdgeInsets.symmetric(horizontal: responsiveWidth(ConstantSizes.sm)),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ConstantColors.buttonDisabled,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_pin,
            color: ConstantColors.primary,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              controller: locationController,
            ),
          ),
        ],
      ),
    );
  }
}
