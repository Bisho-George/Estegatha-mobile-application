import 'dart:async';
import 'package:estegatha/features/tracking/presentation/view/custom_marker.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);

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

  @override
  void initState() {
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

    Timer.periodic(Duration(seconds: 5), (timer) {
      // Stop the timer when the destination is reached
      if ((currentPosition.latitude - destination.latitude).abs() < 0.001 &&
          (currentPosition.longitude - destination.longitude).abs() < 0.001) {
        timer.cancel();
      } else {
        // Calculate the new position (simulating movement)
        double newLat = currentPosition.latitude +
            (destination.latitude - sourceLocation.latitude) / 20;
        double newLng = currentPosition.longitude +
            (destination.longitude - sourceLocation.longitude) / 20;
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
              zoom: 13.5,
              target: currentPosition,
            ),
          ),
        );
      }
    });
  }

  void setCustomMarkerIcon() {
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/Vector-1.png")
    //     .then((icon) {
    //   sourceIcon = icon;
    // });
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/Vector-1.png")
    //     .then((icon) {
    //   destinationIcon = icon;
    // });
    createCustomMarkerBitmap().then((icon) {
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
