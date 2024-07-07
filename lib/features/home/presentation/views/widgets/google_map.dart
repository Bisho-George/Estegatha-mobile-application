import 'package:estegatha/features/home/presentation/view_models/home_state.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_models/home_view_model.dart';
import '../../view_models/sos_zones_view_model/sos_zones_cubit.dart';


class GoogleMapView extends StatelessWidget {
  const GoogleMapView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.position != null) {
              context.read<HomeCubit>().animateCamera();
            }
          },
        ),
        BlocListener<SosZonesCubit, SosZonesState>(
          listener: (context, state) {
            if (state is SosZonesSuccess) {
              // Handle SOS zones update if needed
            }
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<SosZonesCubit, SosZonesState>(
            builder: (context, sosZonesState) {
              Set<Marker> markers = {};
              Set<Circle> circles = {};

              // Add user location marker
              if (homeState.position != null && homeState.customMarker != null) {
                markers.add(
                  Marker(
                    markerId: const MarkerId('userLocation'),
                    position: LatLng(
                      homeState.position!.latitude,
                      homeState.position!.longitude,
                    ),
                    icon: homeState.isAppBarVisible
                        ? homeState.scaledMarker!
                        : homeState.customMarker!,
                    rotation: homeState.bearing,
                    onTap: () {
                      context.read<HomeCubit>().showToggleBar();
                      context.read<HomeCubit>().updateZoom(16);
                    },
                  ),
                );
              }

              // Add SOS zone circles
              if (sosZonesState is SosZonesSuccess) {
                circles.addAll(
                  sosZonesState.sosZones.map((zone) {
                    return Circle(
                      circleId: CircleId(zone.id.toString()),
                      center: LatLng(zone.lat, zone.lang),
                      radius: zone.radius,
                      fillColor: Colors.red.withOpacity(0.5),
                      strokeColor: Colors.red,
                      strokeWidth: 2,
                    );
                  }),
                );
              }

              return GoogleMap(
                onMapCreated: (controller) {
                  context.read<HomeCubit>().setGoogleMapController(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: homeState.position != null
                      ? LatLng(homeState.position!.latitude, homeState.position!.longitude)
                      : const LatLng(0, 0),
                  zoom: homeState.position != null ? 15 : 1,
                  bearing: homeState.bearing,
                ),
                compassEnabled: true,
                myLocationButtonEnabled: true,
                markers: markers,
                circles: circles,
                myLocationEnabled: true,
              );
            },
          );
        },
      ),
    );
  }
}
