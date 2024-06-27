import 'package:estegatha/features/organization/presentation/view/create/create_organization_page.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizationBoardingPage extends StatelessWidget {
  static const String id = 'home_page';

  const OrganizationBoardingPage({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(ConstantSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi ${name.split(' ')[0]}! Now you can join or create your organization',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ConstantColors.primary,
                fontSize: ConstantSizes.headingMd,
                fontWeight: ConstantSizes.fontWeightBold,
              ),
            ),
            Image(
              image: const AssetImage(ConstantImages.organizationBoarding),
              height: 240,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstantSizes.defaultSpace),
              child: SizedBox(
                child: Text(
                  'A Organization is a private space only accessible by you and your organization.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstantColors.darkGrey,
                    fontSize: ConstantSizes.fontSizeMd.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: ConstantSizes.spaceBtwSections),
            CustomElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CreateOrganizationPage()));
                },
                labelText: "Continue")
          ],
        ),
      ),
    );
  }
}
