
import 'package:estegatha/features/sign-up/presentation/view_models/address_view_model.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key, required this.onAddressSelected});

  final Function(String, LatLng) onAddressSelected;

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  final AddressViewModel addressViewModel = AddressViewModel();

  @override
  void initState() {
    super.initState();
    addressViewModel.getCurrentLocation().then((currentPosition) {
      if (currentPosition != null) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0), // Default position, should be replaced later
            zoom: 2,
          ),
          onMapCreated: (GoogleMapController controller) {
            addressViewModel.setController(controller);
            setState(() {});
          },
          onCameraIdle: () async {
            LatLng centerPosition = await addressViewModel.controller!.getLatLng(
              ScreenCoordinate(
                x: (MediaQuery.of(context).size.width / 2).round(),
                y: (MediaQuery.of(context).size.height / 2).round(),
              ),
            );
            String address = await addressViewModel.getAddressFromCoordinates(centerPosition);
            widget.onAddressSelected(address, centerPosition);
          },
        ),
        const Center(
          child: Icon(
            FontAwesomeIcons.mapPin,
            size: 32.0,
            color: ConstantColors.primary,
          ),
        ),
      ],
    );
  }
}
