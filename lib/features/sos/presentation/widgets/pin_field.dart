import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/constant/colors.dart';
class PinField extends StatelessWidget {
  PinField({super.key, this.textColor = ConstantColors.primary, this.index = 0});
  Color textColor;
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            if(index < 3){
              FocusScope.of(context).nextFocus();
            }
            else{
              FocusScope.of(context).unfocus();
            }
          }
          else{
            FocusScope.of(context).previousFocus();
          }
        },
        cursorColor: ConstantColors.primary,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: textColor,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
