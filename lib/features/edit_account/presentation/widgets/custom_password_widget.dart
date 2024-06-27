import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';

class CustomPasswordWidget extends StatefulWidget {
  CustomPasswordWidget(
      {super.key, required this.controller, this.hint = 'Password',});

  String hint;
  TextEditingController controller = TextEditingController();

  @override
  State<CustomPasswordWidget> createState() => _CustomPasswordWidgetState();
}

class _CustomPasswordWidgetState extends State<CustomPasswordWidget> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: responsiveHeight(ConstantSizes.lg),
          horizontal: responsiveWidth(ConstantSizes.lg)),
      height: responsiveHeight(100),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: ConstantColors.primary,
          width: responsiveHeight(2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextField(
              style: Styles.getDefaultPrimary(
                weight: ConstantSizes.fontWeightBold,
                fontSize: ConstantSizes.fontSizeLg,
              ),
              showCursor: true,
              controller: widget.controller,
              cursorColor: ConstantColors.primary,
              autofillHints: const ['password'],
              keyboardType: TextInputType.visiblePassword,
              obscureText: isPasswordHidden,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: Styles.getDefaultSecondary(
                  fontSize: ConstantSizes.fontSizeLg,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              isPasswordHidden
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: ConstantColors.primary,
            ),
            color: ConstantColors.primary,
            onPressed: () {
              setState(() {
                isPasswordHidden = !isPasswordHidden;
              });
            },
          ),
        ],
      )
    );
  }
}
