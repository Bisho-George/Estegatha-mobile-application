
import 'package:estegatha/features/sign-up/data/repos/predictions_maps_api.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/address_text_field_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/views/email_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/otp_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/personal_info_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/address_text_field.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/custom_google_maps.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/common/widgets/custom_elevated_button.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';
import '../view_models/address_view_model.dart';

class AddressView extends StatelessWidget {
  static const String routeName = 'sign-up/address';
  final SignUpViewModel signUpViewModel = SignUpViewModel();
  final AddressViewModel addressViewModel = AddressViewModel();

  AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: ConstantColors.textPrimary,
          ),
          onPressed: () {
            Navigator.pushNamed(context, PersonalInfoView.routeName);
          },
        ),
        title: const Text(
          "Address",
          style: TextStyle(
            fontSize: ConstantSizes.fontSizeLg,
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            BlocProvider.of<SignUpCubit>(context).updateAddress("");
            BlocProvider.of<SignUpCubit>(context).updateLocation(LatLng(0, 0));
            BlocProvider.of<SignUpCubit>(context).signUp();
            Navigator.pushNamed(context, EmailView.routeName);
          }, child: const Text("Remind me later")),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SignUpHeader(
              title: "Home",
              subtitle: "Please enter your home address",
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems),
            Form(
              key: signUpViewModel.addressFormKey,
              child: BlocProvider(
                create: (context) => AddressTextFieldCubit(PredictionsMapsApi()),
                child: Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ConstantSizes.defaultSpace,
                        ),
                        child: BlocBuilder<AddressTextFieldCubit, AddressTextFieldState>(
                          builder: (context, state) {
                            return AddressTextField(
                              controller: addressViewModel.addressController,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ConstantSizes.defaultSpace,
                          vertical: ConstantSizes.defaultSpace,
                        ),
                        child: ProgressIndicatorBar(
                          percentage: .5,
                          step: "2",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ConstantSizes.defaultSpace,
                        ),
                        child: CustomElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, EmailView.routeName);
                          },
                          labelText: "Next",
                        ),
                      ),
                      const SizedBox(height: ConstantSizes.defaultSpace),
                      Expanded(
                        child: Stack(
                          children: [
                            CustomGoogleMaps(
                              onAddressSelected: (String address, LatLng position) {
                                addressViewModel.addressController.text = address;
                                context.read<SignUpCubit>().updateAddress(address);
                                context.read<SignUpCubit>().updateLocation(position);
                              },
                            ),
                            Container(
                              width: double.infinity,
                              color: ConstantColors.secondaryBackground,
                              child: const Text(
                                "Drag the map or enter an address",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ConstantColors.light,
                                  fontSize: ConstantSizes.md,
                                ),
                              ),
                            ),
                            const Center(
                              child: Icon(
                                FontAwesomeIcons.mapPin,
                                size: 32,
                                color: ConstantColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
