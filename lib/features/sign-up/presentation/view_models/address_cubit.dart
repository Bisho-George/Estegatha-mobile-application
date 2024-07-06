import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/services/location_service.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final TextEditingController addressController = TextEditingController();
  late LocationService locationService;
  GoogleMapController? controller;
  bool isFirstCall = true;

  AddressCubit()
      : super(InitialAddressState(
            markers: {},
            cameraPosition: const CameraPosition(
              target: LatLng(30.020811093784804, 31.28244716674089),
              zoom: 12,
            ))) {
    initMapStyle();
  }

  void setController(GoogleMapController controller) {
    this.controller = controller;
  }

  void initMapStyle() {
    locationService = LocationService();
    updateMyLocation();
  }

  void updateMyLocation() async {
    try {
      var locationData = await locationService.getLocation();
      LatLng currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      Marker currentLocationMarker = updateMarker(currentPosition);
      CameraPosition currentCameraPosition = CameraPosition(
        target: currentPosition,
        zoom: 16,
      );
      controller?.animateCamera(
          CameraUpdate.newCameraPosition(currentCameraPosition));
      Set<Marker> markers = state.markers;

      markers.add(currentLocationMarker);
      emit(InitialAddressState(
          markers: markers, cameraPosition: currentCameraPosition));
    } on LocationServiceException catch (e) {
      print(e);
    } on LocationPermissionException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<String> parseAddressFromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placemarks = [];
    try {
      placemarks = await placemarkFromCoordinates(latitude, longitude);
      emit(AddressParsedState(
          markers: state.markers,
          cameraPosition: state.cameraPosition,
          placemarks: placemarks));
    } catch (e) {
      print(e);
    }
    return placemarks.join(", ");
  }

  Marker updateMarker(LatLng currentPosition) {
    Marker currentLocationMarker = Marker(
      markerId: const MarkerId("currentLocation"),
      position: currentPosition,
    );
    return currentLocationMarker;
  }
}
