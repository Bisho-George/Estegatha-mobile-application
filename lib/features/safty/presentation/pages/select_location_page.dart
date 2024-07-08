import 'package:estegatha/features/safty/presentation/view_models/location_feedback_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  GoogleMapController? _controller;
  Marker? currentMarker;
  final double zoom = 14.4746;

  @override
  Widget build(BuildContext context) {
    Geolocator.getCurrentPosition().then((position) {
      LatLng latLng = LatLng(position.latitude, position.longitude);
      setState(() {
        _controller!.animateCamera(CameraUpdate.newLatLngZoom(latLng, zoom));
        currentMarker = Marker(
          markerId: const MarkerId('1'),
          position: latLng,
          visible: true,
          icon: BitmapDescriptor.defaultMarker,
        );
      });
    });
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Select Location',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: ConstantColors.primary,
            ),
            onPressed: () {
              if (currentMarker != null) {
                BlocProvider.of<LocationFeedbackCubit>(context).location = [
                  currentMarker!.position.latitude,
                  currentMarker!.position.longitude
                ];
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Expanded(
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          initialCameraPosition: CameraPosition(
            target: const LatLng(3000, 2000),
            zoom: zoom,
          ),
          markers: currentMarker != null ? {currentMarker!} : {},
          onTap: (LatLng latLng) {
            setState(() {
              currentMarker = Marker(
                markerId: const MarkerId('1'),
                position: latLng,
                visible: true,
                icon: BitmapDescriptor.defaultMarker,
              );
            });
          },
        ),
      ),
    );
  }
}
