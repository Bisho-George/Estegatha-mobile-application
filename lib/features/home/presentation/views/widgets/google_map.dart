import 'package:estegatha/features/home/api/track_api.dart';
import 'package:estegatha/features/home/presentation/view_models/current_oragnization_cubit/current_organization_cubit.dart';
import 'package:estegatha/features/home/presentation/view_models/home_state.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../view_models/home_view_model.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({
    super.key,
  });

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Position? _currentPosition;
  Stream<Position>? _positionStream;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    // Create a stream of position updates
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
     _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
    int? orgId = BlocProvider.of<CurrentOrganizationCubit>(context)
        .currentOrganization
        ?.id;
    int userId =  await HelperFunctions.getUser().then((value) => value.id);
    // Listen to the stream and update the current position
    _positionStream?.listen((Position position) {
      setState(() {
        _currentPosition = position;
        TrackApi().shareLocation(name: "share_location", orgId: orgId!, data: {
          'userId': userId.toString(),
          'orgId': orgId.toString(),
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
          'timestamp': DateTime.now().toString()
        });
      });
    });
    TrackApi()
        .trackEvent(name: "new_location", orgId: orgId!, callback: (data) {
          markers.removeWhere((element) => element.markerId.value == data['userId']);
          Marker marker = Marker(
            markerId: MarkerId(data['userId']),
            position: LatLng(
              double.parse(data['latitude']),
              double.parse(data['longitude']),
            ),
            icon: BitmapDescriptor.defaultMarker,
          );
          markers.add(marker);
          setState(() {
    
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GoogleMap(
          onMapCreated: (controller) {
            context.read<HomeCubit>().setGoogleMapController(controller);
          },
          initialCameraPosition: CameraPosition(
            target: const LatLng(0, 0),
            zoom: state.position != null ? 15 : 1,
            bearing: state.bearing,
          ),
          compassEnabled: true,
          myLocationButtonEnabled: true,
          markers: markers,
          // state.position != null && state.customMarker != null
          //     ? {
          //         Marker(
          //           markerId: const MarkerId('userLocation'),
          //           position: LatLng(
          //             state.position!.latitude,
          //             state.position!.longitude,
          //           ),
          //           icon: state.isAppBarVisible
          //               ? state.scaledMarker!
          //               : state.customMarker!,
          //           rotation: state.bearing,
          //           onTap: () {
          //             context.read<HomeCubit>().showToggleBar();
          //             context.read<HomeCubit>().updateZoom(16);
          //           },
          //         ),
          //       }
          //     : {},
          myLocationEnabled: true,
        );
      },
    );
  }
}
