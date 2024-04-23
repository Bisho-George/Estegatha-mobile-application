import 'package:estegatha/features/sign-up/cubit/date_picker/date_picker_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Flutter Bloc

import '../../../../utils/helpers/validation.dart';

class SignUpView extends StatelessWidget {
  SignUpViewModel data = SignUpViewModel();

  SignUpView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<DatePickerCubit>(
          create: (context) => DatePickerCubit(), // Provide DatePickerCubit
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SignUpHeader(
                  title: "Personal Info.",
                  subtitle: "Please enter your personal information",
                ),
                const SizedBox(height: ConstantSizes.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSizes.defaultSpace,
                  ),
                  child: Form(
                    key: data.formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          labelText: "First Name",
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            data.firstName = value;
                          },
                          validator: (value) =>
                              Validation.validateDefaultFields(
                                  'First Name', value),
                        ),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwInputFields,
                        ),
                        CustomTextField(
                          labelText: "Last Name",
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            data.lastName = value;
                          },
                          validator: (value) =>
                              Validation.validateDefaultFields('Last Name', value),
                        ),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwInputFields,
                        ),
                        BlocBuilder<DatePickerCubit, DatePickerState>(
                          builder: (context, selectedDate) {
                            return CustomTextField(
                              labelText: "Birthday",
                              keyboardType: TextInputType.datetime,
                              onChanged: (value) {
                                data.birthDate = DateTime.parse(value);
                              },
                              validator: (value) =>
                                  Validation.validateBirthdate(value),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.date_range),
                                onPressed: () {
                                  // Show date picker
                                  context.read<DatePickerCubit>().selectDate(context);
                                },
                              ),
                              // Display selected date if available
                              controller: TextEditingController(text: selectedDate?.toString()),
                            );
                          },
                        ),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwInputFields,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
