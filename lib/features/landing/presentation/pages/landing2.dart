import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:estegatha/features/landing/presentation/widgets/permission_widget.dart';
import 'package:estegatha/features/sign-up/presentation/views/personal_info.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';


class Landing2 extends StatelessWidget {
  Landing2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  ConstantImages.AppLogo,
                  width: ConstantSizes.iconXL,
                  height: ConstantSizes.iconXL,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Estegatha requires these permissions to work',
                  style: Styles.getDefaultPrimary(
                    weight: ConstantSizes.fontWeightExtraBold,
                    fontSize: ConstantSizes.headingMd),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: PermissionList.length,
                  itemBuilder: (context, index) {
                    return PermissionWidget(
                      permission: PermissionList.permissions[index],
                    );
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CustomElevatedButton(
                  onPressed: () async {
                    await Permissions().grantPermissions();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpView(),
                      ),
                    );
                  },
                  labelText: "Continue",
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpView(),
                    ),
                  );
                },
                child: Text(
                  'Remind me later',
                  style:Styles.getDefaultPrimary(
                      weight: ConstantSizes.fontWeightBold
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}