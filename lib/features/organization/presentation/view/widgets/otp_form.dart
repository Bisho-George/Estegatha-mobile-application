import 'package:estegatha/features/organization/presentation/view/join/final_join_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPForm extends StatefulWidget {
  const OTPForm({super.key});

  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  List<String> otp = List.filled(6, '');
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  FocusNode buttonFocusNode = FocusNode();

  Widget buildOTPField(int index) {
    return SizedBox(
      height: 50.h,
      width: 50.w,
      child: TextFormField(
        focusNode: focusNodes[index],
        onChanged: (value) {
          // value = value.toUpperCase(); // if you want to convert to uppercase
          if (value.length == 1) {
            if (index < 5) {
              focusNodes[index].unfocus();
              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
            } else {
              focusNodes[index].unfocus();
              FocusScope.of(context).requestFocus(buttonFocusNode);
            }
          }
          if (value.isEmpty && index > 0) {
            focusNodes[index].unfocus();
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
          otp[index] = value;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 231, 231, 231),
        ),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          fontSize: ConstantSizes.headingMd,
          color: ConstantColors.primary,
          fontWeight: ConstantSizes.fontWeightSemiBold,
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              if (index == 3) {
                return const Text('-',
                    style: TextStyle(
                        color: ConstantColors.primary,
                        fontSize: ConstantSizes.headingMd,
                        fontWeight: ConstantSizes.fontWeightBold));
              }
              return buildOTPField(index < 3 ? index : index - 1);
            }),
          ),
          BlocListener<OrganizationCubit, OrganizationState>(
            listener: (context, state) {
              if (state is OrganizationJoinSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinalJoinOrganizationPage(
                      orgId: state.organization.id!,
                    ),
                  ),
                );
              } else if (state is OrganizationFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid OTP. Please try again.'),
                  ),
                );
              }
            },
            child: Column(
              children: [
                const SizedBox(height: ConstantSizes.spaceBtwSections * 2),
                const Text(
                    "Get the code from  the person who setting up your organization",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: ConstantSizes.fontSizeMd,
                    )),
                const SizedBox(height: ConstantSizes.spaceBtwSections),
                CustomElevatedButton(
                  focusNode: buttonFocusNode,
                  onPressed: () {
                    final organizationCubit = context.read<OrganizationCubit>();
                    print("Code: ${otp.join()}");
                    organizationCubit.joinOrganizationByCode(
                        context, otp.join());
                  },
                  labelText: 'Submit',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
