import 'package:estegatha/features/sign-up/presentation/view_models/address_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGoogleMaps extends StatelessWidget {
  CustomGoogleMaps({super.key});

  AddressViewModel addressViewModel = AddressViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(),
      child: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          return GoogleMap(
            onTap: (val) {
              print(val.latitude);
              print(val.longitude);
            },
            initialCameraPosition: state.cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              // addressViewModel.controller = controller;

              context.read<AddressCubit>().setController(controller);
            },
            markers: state.markers,
          );
        },
      ),
    );
  }
}

