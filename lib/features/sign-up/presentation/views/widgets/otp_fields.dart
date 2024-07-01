
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFields extends StatelessWidget {
  const OtpFields({
    super.key,
    required this.signUpViewModel,
  });

  final SignUpViewModel signUpViewModel;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
        children: List.generate(
          6,
          (index) => Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal:responsiveWidth(ConstantSizes.spaceBtwItems / 2)) ,
            child: OtpField(index: index, signUpViewModel: signUpViewModel,))),
        ));
  }
}

class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
    required this.index, required this.signUpViewModel
  });
  final int index;
  final SignUpViewModel signUpViewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomTextField(
        onChanged: (val) {
          if (val.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: signUpViewModel.otpControllers[index],
      ),
    );
  }
}

