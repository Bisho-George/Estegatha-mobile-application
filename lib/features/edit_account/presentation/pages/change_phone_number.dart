import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ChangePhoneNumber extends StatelessWidget {
  static const String routeName = '/change_phone';
  TextEditingController controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ChangePhoneNumber({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Edit Phone Number',
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
        padding: const EdgeInsets.all(16.0),
        child: IntlPhoneField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          initialCountryCode: 'EG',
          validator: (value) {
            if (value == null) {
              return 'Phone number is required';
            }
            return null; // Return null for default validation
          },
          controller: phoneController,
        ),
      ),
    );
  }
}