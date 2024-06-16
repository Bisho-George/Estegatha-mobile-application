import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../views/widgets/marker_generator.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    _loadCustomMarkers();
    _determinePosition();
  }

  GoogleMapController? googleMapController;

  Future<void> _loadCustomMarkers() async {
    BitmapDescriptor? customMarker = await createCustomMarker('B', size: 150.0);
    BitmapDescriptor? scaledMarker = await createCustomMarker('B', size: 180.0);
    emit(state.copyWith(customMarker: customMarker, scaledMarker: scaledMarker));
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();
    emit(state.copyWith(position: position));
  }
  void showToggleBar() {
    emit(state.copyWith(isAppBarVisible: true));
  }
  void hideToggleBar() {
    emit(state.copyWith(isAppBarVisible: false));
  }
  void updateZoom(double zoom) {
    emit(state.copyWith(zoom: zoom));
  }

}
