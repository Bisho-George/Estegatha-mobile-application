
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../utils/services/location_service.dart';

class AddressViewModel {
  late TextEditingController addressController;
  late LocationService locationService;
  GoogleMapController? controller;
  ScrollController? scrollController;

  AddressViewModel() {
    addressController = TextEditingController();
    scrollController = ScrollController();
  }

  void setController(GoogleMapController controller) {
    this.controller = controller;
  }

  Future<LatLng?> getCurrentLocation() async {
    locationService = LocationService();
    var locationData = await locationService.getLocation();
    LatLng currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
    CameraPosition currentCameraPosition = CameraPosition(
      target: currentPosition,
      zoom: 16,
    );
    controller?.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition));
    return currentPosition;
  }

  Future<String> getAddressFromCoordinates(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return "${place.street}, ${place.administrativeArea}, ${place.name}, ${place.country}";
    }
    return "";
  }
}
