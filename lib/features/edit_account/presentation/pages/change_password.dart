import 'package:estegatha/features/edit_account/presentation/widgets/custom_password_widget.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePassword extends StatelessWidget {
  static const String routeName = '/change_password';
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Change Password',
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: ConstantColors.primary,
            onPressed: () {
              String currentPassword = controller1.text;
              String newPassword = controller2.text;
              String retypeNewPassword = controller3.text;
              String ?validationResult = Validation.validatePassword(newPassword);
              if(validationResult == null) {

              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(validationResult),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            padding: EdgeInsets.only(right: responsiveWidth(ConstantSizes.lg)),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(responsiveWidth(ConstantSizes.lg)),
        width: double.infinity,
        height: responsiveHeight(600),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomPasswordWidget(hint: 'Current Password', controller: controller1),
            CustomPasswordWidget(hint: 'New Password', controller: controller2),
            CustomPasswordWidget(hint: 'Re-type New Password', controller: controller3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children :
              [
                Padding(
                  padding: EdgeInsets.only(bottom: responsiveHeight(ConstantSizes.sm)),
                  child: Text('Your new password must have:',
                    style: Styles.getDefaultPrimary(weight: ConstantSizes.fontWeightBold),
                  ),
                ),
                Text('At least 8 characters',
                  style: Styles.getDefaultPrimary(),
                ),
                Text('1 letter and 1 number',
                  style: Styles.getDefaultPrimary(),
                ),
                Text('1 special character (Ex: ? # ! * % \$ @ &)',
                  style: Styles.getDefaultPrimary(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}