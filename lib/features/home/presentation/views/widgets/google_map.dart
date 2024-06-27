import 'package:estegatha/features/home/presentation/view_models/home_state.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_models/home_view_model.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GoogleMap(
          onMapCreated: (controller) {
            context
                .read<HomeCubit>()
                .setGoogleMapController(controller);
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
            zoom: state.position != null ? 15 : 1,
            bearing: state.bearing,
          ),
          compassEnabled: true,
          myLocationButtonEnabled: true,
          markers: state.position != null && state.customMarker != null
              ? {
            Marker(
              markerId: const MarkerId('userLocation'),
              position: LatLng(
                state.position!.latitude,
                state.position!.longitude,
              ),
              icon: state.isAppBarVisible
                  ? state.scaledMarker!
                  : state.customMarker!,
              rotation: state.bearing,
              onTap: () {
                context.read<HomeCubit>().showToggleBar();
                context.read<HomeCubit>().updateZoom(16);
              },
            ),
          }
              : {},
          myLocationEnabled: true,
        );
      },
    );
  }
}
