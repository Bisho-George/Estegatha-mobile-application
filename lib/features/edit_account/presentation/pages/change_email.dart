import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/material.dart';

class ChangeEmailPage extends StatelessWidget {
  static const String routeName = '/change_email';
  TextEditingController controller = TextEditingController();

  ChangeEmailPage({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Change Email',
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: ConstantColors.primary,
            onPressed: () {
              String email = controller.text;
              String ?validationResult = Validation.validateEmail(email);
              if(validationResult == null) {

              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(validationResult),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            padding: EdgeInsets.only(right: responsiveWidth(20)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: responsiveHeight(ConstantSizes.md), horizontal: responsiveWidth(16)),
        child: Container(
          padding: EdgeInsets.all(responsiveHeight(20)),
          height: responsiveHeight(100),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsiveHeight(40)),
            border: Border.all(
              color: ConstantColors.primary,
              width: responsiveHeight(2),
            ),
          ),
          child: TextField(
            style: Styles.getDefaultPrimary(weight: ConstantSizes.fontWeightBold),
            controller: controller,
            autofillHints: const ['email'],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your new email',
              hintStyle: Styles.getDefaultSecondary(),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}