part of 'address_cubit.dart';

@immutable
sealed class AddressState {
  final Set<Marker> markers;
  final CameraPosition cameraPosition;

  AddressState({required this.markers, required this.cameraPosition});
}

class InitialAddressState extends AddressState {
  InitialAddressState({
    required Set<Marker> markers,
    required CameraPosition cameraPosition,
  }) : super(
    markers: markers,
    cameraPosition: cameraPosition,
  );
}

class AddressParsedState extends AddressState {
  final List<Placemark> placemarks;

  AddressParsedState({
    required Set<Marker> markers,
    required CameraPosition cameraPosition,
    required this.placemarks,
  }) : super(
    markers: markers,
    cameraPosition: cameraPosition,
  );
}
