import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:estegatha/features/landing/presentation/view_model/permissions_cubit.dart';
import 'package:estegatha/features/landing/presentation/widgets/permission_widget.dart';
import 'package:estegatha/features/sign-up/presentation/views/personal_info_view.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/permissions_state.dart';

class Landing2 extends StatelessWidget {
  Landing2({super.key});
  static String routeName = '/landing2';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocListener<PermissionCubit, PermissionState>(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: responsiveHeight(ConstantSizes.xl)),
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
                padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(20),
                    vertical: responsiveHeight(20)),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: PermissionList.length,
                  itemBuilder: (context, index) {
                    return PermissionWidget(
                      permission: PermissionList.permissions[index],
                    );
                  },
                )),
            CustomElevatedButton(
              onPressed: () {
                BlocProvider.of<PermissionCubit>(context).grantPermissions();
              },
              labelText: "Continue",
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInfoView(),
                  ),
                );
              },
              child: Text(
                'Remind me later',
                style: Styles.getDefaultPrimary(
                    weight: ConstantSizes.fontWeightBold),
              ),
            ),
          ],
        ),
        listener: (context, state) {
          if (state is PermissionStateFinished) {
            Navigator.pushNamed(context, PersonalInfoView.routeName);
          }
        },
      ),
    );
  }
}
