import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_cubit.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
class ChangePhoneNumber extends StatelessWidget {
  static const String routeName = '/change_phone';
  TextEditingController controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isValid = false;
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
              if(isValid) {
                BlocProvider.of<EditAccountCubit>(context).editPhone();
                Navigator.pop(context);
              }
            },
            padding: EdgeInsets.only(right: responsiveWidth(20)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: responsiveHeight(ConstantSizes.md), horizontal: responsiveWidth(ConstantSizes.md)),
        child: IntlPhoneField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          initialCountryCode: 'EG',
          controller: phoneController,
          onChanged: (phone) {
            BlocProvider.of<EditAccountCubit>(context).phone = phone.completeNumber;
            isValid = phone.isValidNumber();
          },
        ),
      ),
    );
  }
}