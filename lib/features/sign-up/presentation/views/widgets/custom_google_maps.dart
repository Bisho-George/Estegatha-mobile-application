
import 'package:estegatha/features/sign-up/presentation/view_models/address_view_model.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({
    super.key,
    required this.onAddressSelected,
    required this.onLoadingAddressChanged,
  });

  final Function(String, LatLng) onAddressSelected;
  final Function(bool) onLoadingAddressChanged;

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  final AddressViewModel addressViewModel = AddressViewModel();
  bool _isLoadingAddress = false;
  String? _errorMessage;

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
            setState(() {
              _isLoadingAddress = true;
              _errorMessage = null;
            });
            widget.onLoadingAddressChanged(true);

            try {
              LatLng centerPosition = await addressViewModel.controller!.getLatLng(
                ScreenCoordinate(
                  x: (MediaQuery.of(context).size.width / 2).round(),
                  y: (MediaQuery.of(context).size.height / 2).round(),
                ),
              );
              String address = await addressViewModel.getAddressFromCoordinates(centerPosition);
              widget.onAddressSelected(address, centerPosition);
            } on PlatformException catch (e) {
              setState(() {
                _errorMessage = 'No address information found for the selected location.';
              });
            } catch (e) {
              setState(() {
                _errorMessage = 'An error occurred while fetching address information.';
              });
            } finally {
              setState(() {
                _isLoadingAddress = false;
              });
              widget.onLoadingAddressChanged(false);
            }
          },
        ),
        const Center(
          child: Icon(
            FontAwesomeIcons.mapPin,
            size: 32.0,
            color: ConstantColors.primary,
          ),
        ),
        if (_isLoadingAddress)
          const Center(
            child: CircularProgressIndicator(),
          ),
        if (_errorMessage != null)
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.red,
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
