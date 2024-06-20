import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/sizes.dart';
import 'add_widget.dart';
class AddContactWidget extends StatelessWidget {
  AddContactWidget({
    super.key,
    required this.onTap
  });
  void Function ()onTap;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16), vertical: responsiveHeight(16)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            const AddWidget(),
            SizedBox(
              width: responsiveWidth(8),
            ),
            Text(
              'Add New Contact',
              style: Styles.getDefaultPrimary(
                weight: ConstantSizes.fontWeightBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}