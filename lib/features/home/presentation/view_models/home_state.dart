import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeState {
  final Position? position;
  final BitmapDescriptor? customMarker;
  final BitmapDescriptor? scaledMarker;
  final double bearing;
  final bool isAppBarVisible;
  final double zoom;

  HomeState({
    this.position,
    this.customMarker,
    this.scaledMarker,
    this.bearing = 0,
    this.isAppBarVisible = false,
    this.zoom = 15,  // Default zoom level
  });

  HomeState copyWith({
    Position? position,
    BitmapDescriptor? customMarker,
    BitmapDescriptor? scaledMarker,
    double? bearing,
    bool? isAppBarVisible,
    double? zoom,
  }) {
    return HomeState(
      position: position ?? this.position,
      customMarker: customMarker ?? this.customMarker,
      scaledMarker: scaledMarker ?? this.scaledMarker,
      bearing: bearing ?? this.bearing,
      isAppBarVisible: isAppBarVisible ?? this.isAppBarVisible,
      zoom: zoom ?? this.zoom,
    );
  }
}

