import 'package:estegatha/features/sign-up/domain/models/personal_info_model.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/views/email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              decoration: InputDecoration(
                prefixIconColor: ConstantColors.darkGrey,
                suffixIconColor: ConstantColors.darkGrey,
                labelText: "Phone Number",
                labelStyle: const TextStyle(
                  fontSize: ConstantSizes.fontSizeMd,
                  color: ConstantColors.darkGrey,
                ),
                hintStyle: const TextStyle(
                  fontSize: ConstantSizes.fontSizeMd,
                  color: ConstantColors.darkGrey,
                ),
                errorStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                ),
                floatingLabelStyle: TextStyle(
                  color: ConstantColors.primary.withOpacity(0.8),
                ),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(ConstantSizes.inputFieldRadius),
                  borderSide: const BorderSide(
                      width: 1, color: ConstantColors.textInputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(ConstantSizes.inputFieldRadius),
                  borderSide: const BorderSide(
                      width: 1, color: ConstantColors.textInputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(ConstantSizes.inputFieldRadius),
                  borderSide: const BorderSide(
                    width: 1,
                    color: ConstantColors.borderPrimary,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(ConstantSizes.inputFieldRadius),
                  borderSide: const BorderSide(
                    width: 1,
                    color: ConstantColors.warning,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(ConstantSizes.inputFieldRadius),
                  borderSide: const BorderSide(
                    width: 2,
                    color: ConstantColors.warning,
                  ),
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
                    PersonalInfoModel personalInfo = PersonalInfoModel(
                      firstName: data.firstNameController.text,
                      lastName: data.lastNameController.text,
                      birthday: birthday,
                      phoneNumber: data.phoneController.text,
                    );
                    BlocProvider.of<SignUpCubit>(context)
                        .updatePersonalInfo((personalInfo));

                    // Navigate to the email page
                    Navigator.pushNamed(context, EmailView.routeName);
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SignInPage();
                    }));
                  },
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
