import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../utils/services/location_service.dart';

class MapViewModel {
  double radius = 100;
  LatLng currentLocation = const LatLng(0, 0);
  GoogleMapController? mapController;
  final LocationService locationService = LocationService();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan); // Set marker color
  bool isLocationInitialized = false; // Flag to check if location is initialized

  Future<void> initializeLocation() async {
    try {
      final locationData = await locationService.getLocation();
      currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      isLocationInitialized = true; // Set the flag to true after location is initialized
      updateMap();
    } catch (e) {
      // Handle location service or permission exceptions
    }
  }

  void updateMap() {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation, 15),
      );
    }
  }
}
