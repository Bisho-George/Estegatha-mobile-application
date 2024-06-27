import 'package:estegatha/features/organization/presentation/view/widgets/cubit/otp_cubit.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/otp_form.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinOrganizationPage extends StatefulWidget {
  const JoinOrganizationPage({super.key, this.title});
  final String? title;

  @override
  _JoinOrganizationPage createState() => _JoinOrganizationPage();
}

class _JoinOrganizationPage extends State<JoinOrganizationPage> {
  ValueNotifier<bool> isOtpWrong = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(ConstantSizes.appBarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: ConstantColors.white,
              boxShadow: [
                BoxShadow(
                  color: ConstantColors.grey,
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          leading: Padding(
            // Wrap the leading widget with Padding
            padding:
                const EdgeInsets.only(top: 10.0), // Adjust the value as needed
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ConstantColors.primary,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Join Organization',
              style: TextStyle(
                color: ConstantColors.primary,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: ConstantSizes.spaceBtwSections * 2,
            horizontal: ConstantSizes.defaultSpace),
        child: Column(
          children: [
            const Text(
              "Enter the invite code",
              style: TextStyle(
                color: ConstantColors.primary,
                fontSize: ConstantSizes.headingMd,
                fontWeight: ConstantSizes.fontWeightBold,
              ),
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwSections,
            ),
            BlocProvider(
              create: (context) => OtpCubit(),
              child: const OTPForm(),
            ),
          ],
        ),
      ),
    );
  }
}
