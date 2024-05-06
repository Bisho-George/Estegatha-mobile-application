import 'package:estegatha/features/sign-up/presentation/views/personal_info_view.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../utils/common/widgets/custom_elevated_button.dart';
import '../../../../../utils/common/widgets/custom_text_field.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../../../utils/helpers/validation.dart';
import '../../view_models/date_picker_view_model.dart';
import '../../view_models/sign_up_view_model.dart';
class PersonalInfoForm extends StatelessWidget {
  SignUpViewModel data = SignUpViewModel();
  DatePickerViewModel datepickerVM = DatePickerViewModel();


  PersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ConstantSizes.defaultSpace,
      ),
      child: Form(
        key: data.personalInfoFormKey,
        child: Column(
          children: [
            CustomTextField(
              labelText: "First Name",
              keyboardType: TextInputType.text,
              validator: (value) =>
                  Validation.validateDefaultFields('First Name', value),
              controller: data.firstNameController,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            CustomTextField(
              labelText: "Last Name",
              keyboardType: TextInputType.text,
              validator: (value) =>
                  Validation.validateDefaultFields('Last Name', value),
              controller: data.lastNameController,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            CustomTextField(
              labelText: "Birthday",
              keyboardType: TextInputType.datetime,
              validator: (value) => Validation.validateBirthdate(value),
              hintText: "DD/MM/YYYY",
              onPressed: () {
                data.selectDate(context);
              },
              suffixIcon: IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () {
                  // Show date picker
                  data.selectDate(context);
                },
              ),
              // Use the initialized birthday controller
              controller: data.birthdayController,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            IntlPhoneField(
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
              controller: data.phoneController,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            CustomElevatedButton(
                onPressed: () {
                  if (data.personalInfoFormKey.currentState!.validate()) {
                    // Parse the birthdayController.text to DateTime
                    DateTime? birthday =
                        datepickerVM.parseDate(data.birthdayController.text);
                    // data.user.firstName = data.firstNameController.text;
                    // data.user.lastName = data.lastNameController.text;
                    // data.user.birthday = birthday;
                    // data.user.phoneNumber = data.phoneController.text;
                    Navigator.pushNamed(context, 'sign-up/email');
                  }
                },
                labelText: "Next"),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: ConstantColors.textSecondary,
                      fontWeight: ConstantSizes.fontWeightSemiBold,
                      fontSize: ConstantSizes.fontSizeMd),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Sign in",
                      style: TextStyle(
                          color: ConstantColors.textPrimary,
                          fontWeight: ConstantSizes.fontWeightBold,
                          fontSize: ConstantSizes.fontSizeMd)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
