import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/common/widgets/custom_elevated_button.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';

class DangerousDialog extends StatelessWidget {
  const DangerousDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 400,
        decoration: ShapeDecoration(
          color: Color(0xFFF6F6F8),
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                20),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 3),
              spreadRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: ConstantSizes.defaultSpace),
          child: Column(
            children: [
              Text("Dangerous Area", style: TextStyle(
                color: ConstantColors.primary,
                fontSize: ConstantSizes.fontSizeLg,
                fontWeight: ConstantSizes.fontWeightBold,
              ),),
              Divider(thickness: 3, color: Color(0xffededed),),
              SizedBox(height: ConstantSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    fit: BoxFit.cover,
                    ConstantImages.dialogIcon,
                  ),
                  SizedBox(width: ConstantSizes.spaceBtwItems),
                  Text("Fire", style: TextStyle(
                    color: Color(0xffFF5C5C),
                    fontSize: ConstantSizes.fontSizeLg,
                    fontWeight: ConstantSizes.fontWeightBold,
                  ),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(ConstantSizes.defaultSpace),
                child: Column(
                  children: [
                    Text("This area has been marked as dangerous area. Don’t hesitate to ask for help ", style: TextStyle(
                      color: ConstantColors.textSecondary,

                    ),
                      maxLines: 3,
                      textAlign: TextAlign.center,),

                    SizedBox(height: ConstantSizes.defaultSpace),
                    CustomElevatedButton(
                        onPressed: () {}, labelText: "See More Details"),
                    SizedBox(height: ConstantSizes.spaceBtwItems),
                    CustomElevatedButton(onPressed: () {}, labelText: "Notify Your Organization"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
