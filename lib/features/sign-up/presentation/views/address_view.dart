import 'package:estegatha/features/sign-up/data/repositories/predictions_maps_api.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/address_text_field_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/address_text_field.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/custom_google_maps.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/common/widgets/custom_elevated_button.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';
import '../view_models/address_view_model.dart';

class AddressView extends StatelessWidget {
  static const String routeName = 'sign-up/address';
  SignUpViewModel signUpViewModel = SignUpViewModel();
  AddressViewModel addressViewModel = AddressViewModel();

  AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          const SignUpHeader(
              title: "Home", subtitle: "Please enter your home address"),
          const SizedBox(
            height: ConstantSizes.spaceBtwItems,
          ),
          Stack(
            children: [
              Form(
                  key: signUpViewModel.addressFormKey,
                  child: BlocProvider(
                    create: (context) =>
                        AddressTextFieldCubit(PredictionsMapsApi()),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: ConstantSizes.defaultSpace),
                          child: BlocBuilder<AddressTextFieldCubit,
                              AddressTextFieldState>(
                            builder: (context, state) {
                              final cubit =
                                  context.read<AddressTextFieldCubit>();
                              return Column(
                                children: [
                                  AddressTextField(
                                    controller: cubit.controller,
                                    onChanged: (val) {
                                      if (val.toString().isNotEmpty) {
                                        BlocProvider.of<AddressTextFieldCubit>(
                                                context)
                                            .updatePredictions(val.toString());
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: ConstantSizes.defaultSpace,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ConstantSizes.defaultSpace),
                                      child: Column(
                                        children: [
                                          ProgressIndicatorBar(
                                            percentage: 1,
                                            step: "4",
                                          ),
                                          const SizedBox(
                                            height: ConstantSizes.defaultSpace,
                                          ),
                                          CustomElevatedButton(
                                              onPressed: () {},
                                              labelText: "Next"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: ConstantSizes.defaultSpace,
                                    ),
                                    Stack(children: [
                                      SizedBox(
                                          width: 450,
                                          height: 350,
                                          child: CustomGoogleMaps()),
                                      Container(
                                        width: double.infinity,
                                        color:
                                            ConstantColors.secondaryBackground,
                                        child: const Text(
                                          "Drag the map or enter an address",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: ConstantColors.light,
                                              fontSize: ConstantSizes.md),
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: ConstantSizes.defaultSpace),
                                  child: BlocBuilder<AddressTextFieldCubit,
                                          AddressTextFieldState>(
                                      builder: (context, state) {
                                    if (state is AddressPredictionsLoadingState)
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    if (state is AddressPredictionsErrorState) {
                                      return const Center(
                                        child: Text(
                                            "Error in making predicitions"),
                                      );
                                    }
                                    if (state
                                        is AddressPredictionsLoadedState) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 150,
                                              color: Colors.white,
                                              child: RawScrollbar(
                                                thumbColor:
                                                    ConstantColors.primary,
                                                radius:
                                                    const Radius.circular(10),
                                                thickness: 5,
                                                interactive: true,
                                                controller: addressViewModel
                                                    .scrollController,
                                                thumbVisibility: true,
                                                child: ListView.separated(
                                                    controller: addressViewModel
                                                        .scrollController,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                          leading: Image.asset(
                                                            ConstantImages
                                                                .googleMapsIcon,
                                                            width: 30,
                                                            height: 30,
                                                            fit: BoxFit.contain,
                                                          ),
                                                          title: Text("data"),
                                                          trailing: IconButton(
                                                            icon: Icon(
                                                                color:
                                                                    ConstantColors
                                                                        .primary,
                                                                FontAwesomeIcons
                                                                    .circleRight),
                                                            onPressed: () {},
                                                          ));
                                                    },
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return const Divider(
                                                        height: 0,
                                                      );
                                                    },
                                                    itemCount: state
                                                        .predictions.length),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
