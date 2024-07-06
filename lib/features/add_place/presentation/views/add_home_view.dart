
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';

class AddHomeView extends StatelessWidget {
  static const String routeName = '/add_home';

  const AddHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add a new Place',
            style: TextStyle(
              color: ConstantColors.primary,
              fontSize: ConstantSizes.fontSizeLg,
              fontWeight: ConstantSizes.fontWeightRegular,
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Save')),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.2,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.fromLTRB(
              ConstantSizes.defaultSpace,
              ConstantSizes.defaultSpace,
              ConstantSizes.defaultSpace,
              ConstantSizes.defaultSpace,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.bookmark,
                              color: Colors.grey[400],
                            ),
                            hintText: "Place type",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ConstantSizes.defaultSpace),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              FontAwesomeIcons.locationDot,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: CustomGoogleMaps()),
        ],
      ),
    );
  }
}

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  double _radius = 100;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        const Expanded(
          flex: 4,
          child: GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 1,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(ConstantSizes.defaultSpace)),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child:Slider(
                  activeColor: ConstantColors.primary,
                  value: _radius,
                  onChanged: (value) {
                    setState(() {
                      _radius = value;
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      _radius = value.round().toDouble();
                    });
                  },
                  min: 100,
                  max: 1000,
                  divisions: 900,
                  label: 'Radius: ${_radius.round()}',
                ),
              ),
              Text('Radius: $_radius')
            ],
          ),
        ),
      ],
    );
  }
}
