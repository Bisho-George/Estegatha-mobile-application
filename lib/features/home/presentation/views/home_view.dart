import 'package:estegatha/features/home/presentation/views/widgets/draggable_scroll_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/common/widgets/bottom_navbar.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/image_strings.dart';
import '../view_models/home_state.dart';
import '../view_models/home_view_model.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) async {
            if (state.position != null) {
              BlocProvider.of<HomeCubit>(context)
                  .googleMapController
                  ?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          state.position!.latitude,
                          state.position!.longitude,
                        ),
                        zoom: state.zoom,
                        bearing: state.bearing,
                      ),
                    ),
                  );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    BlocProvider.of<HomeCubit>(context).googleMapController =
                        controller;
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
                              BlocProvider.of<HomeCubit>(context)
                                  .updateZoom(16);
                            },
                          ),
                        }
                      : {},
                  myLocationEnabled: true,
                ),
                if (state.position != null && state.customMarker != null) ...[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: state.isAppBarVisible ? 0 : -100,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          context.read<HomeCubit>().hideToggleBar();
                          BlocProvider.of<HomeCubit>(context).updateZoom(15);
                        },
                      ),
                      title: Text('Bishoy'),
                    ),
                  ),
                  Positioned(
                    height: 400,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [DraggableScrollSheet(), BottomNavBar()],
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    // Adjusted to not overlap with BottomNavBar and DraggableScrollSheet
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ConstantColors.primary,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 10,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: FloatingActionButton(
                        clipBehavior: Clip.none,
                        backgroundColor: ConstantColors.secondaryBackground,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(ConstantImages.organizationIcon),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
