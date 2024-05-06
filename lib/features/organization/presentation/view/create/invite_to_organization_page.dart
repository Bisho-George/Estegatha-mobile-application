import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteToOrganizationPage extends StatelessWidget {
  static const String id = 'home_page';

  const InviteToOrganizationPage({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final String code =
        BlocProvider.of<OrganizationCubit>(context).state.organization!.code;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invite Members',
          style: TextStyle(
              color: ConstantColors.primary,
              fontSize: ConstantSizes.headingSm.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace.h),
          child: Column(
            children: <Widget>[
              Text(
                'invite members to the $name organization',
                style: TextStyle(
                  color: ConstantColors.primary,
                  fontSize: ConstantSizes.headingMd.sp,
                  fontWeight: ConstantSizes.fontWeightBold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ConstantSizes.md.h),
                child: SizedBox(
                  child: Text(
                    'Share your code out loud or send it in a message.',
                    style: TextStyle(
                      color: ConstantColors.darkGrey,
                      fontSize: ConstantSizes.fontSizeMd.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: (ConstantSizes.spaceBtwSections.h)),
              SizedBox(
                width: 300.w, // your custom width
                height: 200.h,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ConstantSizes.buttonRadius),
                  ),
                  color: ConstantColors.grey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${code.substring(0, code.length ~/ 2)}-${BlocProvider.of<OrganizationCubit>(context).state.organization!.code.substring(code.length ~/ 2)}',
                          style: TextStyle(
                            letterSpacing: 2,
                            color: ConstantColors.primary,
                            fontSize: ConstantSizes.headingLg.sp,
                            fontWeight: ConstantSizes.fontWeightExtraBold,
                          ),
                        ),
                        SizedBox(height: ConstantSizes.sm.h),
                        const Text(
                          'This code is valid for 24 hours.',
                          style: TextStyle(
                            color: ConstantColors.primary,
                            fontSize: ConstantSizes
                                .fontSizeMd, // your custom font size
                          ),
                        ),
                        SizedBox(height: ConstantSizes.defaultSpace.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ConstantSizes.defaultSpace.w * 2),
                          child: CustomElevatedButton(
                              onPressed: () {}, labelText: "Send Code"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: ConstantSizes.spaceBtwItems.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ConstantSizes.defaultSpace.w * 2),
                child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    labelText: "Done"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
