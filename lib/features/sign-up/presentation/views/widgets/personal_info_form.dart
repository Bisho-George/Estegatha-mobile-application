import 'package:estegatha/features/sign-up/domain/entities/personal_info_entity.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/address_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/views/address_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/already_have_account.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/birthday_field.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/phone_field.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/common/widgets/custom_elevated_button.dart';
import '../../../../../utils/common/widgets/custom_text_field.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../../../utils/helpers/validation.dart';
import '../../view_models/date_picker_view_model.dart';
import '../../view_models/sign_up_view_model.dart';

class PersonalInfoForm extends StatefulWidget {
  PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  SignUpViewModel signUpViewModel = SignUpViewModel();

  DatePickerViewModel datepickerVM = DatePickerViewModel();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(ConstantSizes.defaultSpace),
      ),
      child: Form(
        key: signUpViewModel.personalInfoFormKey,
        child: Column(
          children: [
            CustomTextField(
              labelText: "First Name",
              keyboardType: TextInputType.text,
              validator: (value) =>
                  Validation.validateDefaultFields('First Name', value),
              controller: signUpViewModel.firstNameController,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            CustomTextField(
              labelText: "Last Name",
              keyboardType: TextInputType.text,
              validator: (value) =>
                  Validation.validateDefaultFields('Last Name', value),
              controller: signUpViewModel.lastNameController,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            BirthdayField(data: signUpViewModel),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            PhoneField(data: signUpViewModel),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            CustomElevatedButton(
                onPressed: () {
                  signUpViewModel.validateForm(context, AddressView.routeName);
                },
                labelText: "Next"),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            const AlreadyHaveAccount()
          ],
        ),
      ),
    );
  }
}
