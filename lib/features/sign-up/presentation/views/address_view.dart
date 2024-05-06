import 'dart:async';

import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/common/widgets/custom_elevated_button.dart';
import '../../../../utils/common/widgets/custom_text_field.dart';
import '../../../../utils/constant/sizes.dart';

class AddressView extends StatelessWidget {
  static const String routeName = 'sign-up/address';
  SignUpViewModel signUpViewModel = SignUpViewModel();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.020811093784804, 31.28244716674089),
    zoom: 8,
  );

  AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SignUpHeader(
                title: "Home", subtitle: "Please enter your home address"),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ConstantSizes.defaultSpace,
              ),
              child: Form(
                key: signUpViewModel.addressFormKey,
                child: Column(
                  children: [
                    const CustomTextField(
                      labelText: "Address",
                      hintText: "Your address",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: ConstantSizes.spaceBtwInputFields,
                    ),
                    ProgressIndicatorBar(
                      percentage: 1,
                      step: "4",
                    ),
                    const SizedBox(
                      height: ConstantSizes.spaceBtwItems,
                    ),
                    CustomElevatedButton(onPressed: () {}, labelText: "Next"),
                    const SizedBox(
                      height: ConstantSizes.spaceBtwItems,
                    ),
                  ],
                ),
              ),
            ),
            Stack(children: [

              // Container(
              //   width: double.infinity,
              //   height: 100,
              Container(
                width: 450,
                height: 344,
                child: GoogleMap(
                  onTap: (val) {
                    print(val.latitude);
                    print(val.longitude);
                  },
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),Container(
                width: double.infinity,
                color: ConstantColors.secondaryBackground,
                child: const Text(
                  "Drag the map or enter an address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ConstantColors.light, fontSize: ConstantSizes.md),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
