import 'package:estegatha/features/add_place/presentation/view_models/boundary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../responsive/size_config.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../view_models/map_view_model.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late final MapViewModel mapViewModel;

  @override
  void initState() {
    mapViewModel = MapViewModel();
    mapViewModel.initializeLocation().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        _buildGoogleMap(),
        _buildSlider(),
      ],
    );
  }

  Expanded _buildGoogleMap() {
    return Expanded(
      flex: 4,
      child: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: mapViewModel.currentLocation,
          zoom: 15,
        ),
        onMapCreated: (controller) {
          mapViewModel.mapController = controller;
          if (mapViewModel.isLocationInitialized) {
            BlocProvider.of<BoundaryCubit>(context).updateLatLng(
                mapViewModel.currentLocation.latitude,
                mapViewModel.currentLocation.longitude);
            mapViewModel.updateMap();
          }
        },
        markers: mapViewModel.isLocationInitialized
            ? {
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: mapViewModel.currentLocation,
            icon: mapViewModel.markerIcon,
          ),
        }
            : {},
        circles: mapViewModel.isLocationInitialized ? {
          Circle(
            circleId: const CircleId('radiusCircle'),
            center: mapViewModel.currentLocation,
            radius: mapViewModel.radius,
            fillColor: ConstantColors.primary.withOpacity(0.2),
            strokeColor: ConstantColors.primary,
            strokeWidth: 1,
          ),
        } : {},
      ),
    );
  }

  Padding _buildSlider() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(ConstantSizes.defaultSpace),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Slider(
              activeColor: ConstantColors.primary,
              value: mapViewModel.radius,
              onChanged: (value) {
                setState(() {
                  mapViewModel.radius = value;
                });
              },
              onChangeEnd: (value) {
                setState(() {
                  mapViewModel.radius = value.round().toDouble();
                  BlocProvider.of<BoundaryCubit>(context).updateRadius(
                      mapViewModel.radius);
                  mapViewModel.updateMap();
                });
              },
              min: 100,
              max: 1000,
              divisions: 900,
              label: 'Radius: ${mapViewModel.radius.round()}',
            ),
          ),
          Text('Radius: ${mapViewModel.radius}')
        ],
      ),
    );
  }
}
