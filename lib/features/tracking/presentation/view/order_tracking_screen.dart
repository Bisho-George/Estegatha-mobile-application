import 'dart:async';
import 'package:estegatha/features/organization/presentation/view/main/track_cubit/track_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/features/tracking/presentation/view/custom_marker.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math' as math;

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => OrderTrackingScreenState();
}

class OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(29.922795, 31.0226133);
  static const LatLng destination = LatLng(29.9710, 31.0364);

  List<LatLng> polylineCoordinates = [sourceLocation];
  LocationData? currentLocation;
  Set<Marker> markers = {};
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  String username = '';
  double currentZoomLevel = 13.5;

  @override
  void initState() {
    username = context.read<TrackCubit>().getTrackedMemberName();
    super.initState();
    setCustomMarkerIcon();
    markers.addAll({
      Marker(
        markerId: const MarkerId("source"),
        position: sourceLocation,
        icon: sourceIcon,
      ),
      Marker(
        markerId: const MarkerId("destination"),
        position: destination,
        icon: destinationIcon,
      ),
    });
    simulateMovement();
  }

  void simulateMovement() async {
    LatLng currentPosition = sourceLocation;
    GoogleMapController googleMapController = await _controller.future;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      // Stop the timer when the destination is reached
      if ((currentPosition.latitude - destination.latitude).abs() < 0.001 &&
          (currentPosition.longitude - destination.longitude).abs() < 0.001) {
        timer.cancel();
      } else {
        // Calculate the general direction to the destination
        double latDirection = destination.latitude - currentPosition.latitude;
        double lngDirection = destination.longitude - currentPosition.longitude;

        // Normalize the direction
        double magnitude = math
            .sqrt(latDirection * latDirection + lngDirection * lngDirection);
        latDirection /= magnitude;
        lngDirection /= magnitude;

        // Apply a random factor around the general direction
        double newLat = currentPosition.latitude +
            latDirection * 0.001 * math.Random().nextDouble();
        double newLng = currentPosition.longitude +
            lngDirection * 0.001 * math.Random().nextDouble();

        currentPosition = LatLng(newLat, newLng);

        setState(() {
          polylineCoordinates.add(currentPosition);
          markers.removeWhere(
              (marker) => marker.markerId == const MarkerId("currentLocation"));
          markers.add(Marker(
            markerId: const MarkerId("currentLocation"),
            position: currentPosition,
            icon: currentLocationIcon,
          ));
        });

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: currentZoomLevel, // Use the current zoom level
              target: currentPosition,
            ),
          ),
        );
      }
    });
  }

  void setCustomMarkerIcon() {
    createCustomMarkerBitmap(username).then((icon) {
      currentLocationIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: sourceLocation,
          zoom: 13.5,
        ),
        onCameraMove: (CameraPosition position) {
          currentZoomLevel =
              position.zoom; // Update the current zoom level on camera move
        },
        markers: markers,
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: ConstantColors.secondary,
            width: 6,
          ),
        },
      ),
    );
  }
}
