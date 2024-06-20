import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/model/contact_model.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, required this.contact});
  final ContactModel contact;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        contact.name,
      ),
      subtitle: Text(
        contact.phoneNumber,
      ),
      titleTextStyle: Styles.getDefaultPrimary(
        weight: ConstantSizes.fontWeightExtraBold,
      ),
      subtitleTextStyle: Styles.getDefaultSecondary(),
      shape: LinearBorder.bottom(
        side: BorderSide(
          color: ConstantColors.grey,
        ),
      ),
    );
  }
}
