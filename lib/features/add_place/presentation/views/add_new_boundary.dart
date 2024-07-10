import 'package:dio/dio.dart';
import 'package:estegatha/features/add_place/data/data_source/boundary_remote_data_source.dart';
import 'package:estegatha/features/add_place/data/repos/boundary_repo_imp.dart';
import 'package:estegatha/features/add_place/domain/use_cases/add_boundary_use_case.dart';
import 'package:estegatha/features/add_place/domain/use_cases/get_boundaries_use_case.dart';
import 'package:estegatha/features/add_place/presentation/view_models/boundary_cubit.dart';
import 'package:estegatha/features/add_place/presentation/views/add_boundary_view.dart';
import 'package:estegatha/features/add_place/presentation/views/widgets/place_option.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';
import '../../../../utils/services/api_service.dart';

class AddNewBoundary extends StatelessWidget {
  static const String routeName = '/add_new_boundary';

  AddNewBoundary({super.key, this.parentContext});
  BuildContext ?parentContext;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add a new boundary',
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
        ),
        body: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.13,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: ConstantColors.grey,
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(
                    ConstantSizes.defaultSpace, ConstantSizes.defaultSpace,
                    ConstantSizes.defaultSpace,
                    ConstantSizes.defaultSpace * 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          hintText: "Search address or location na...",
                          hintStyle: TextStyle(
                            color: ConstantColors.darkGrey,
                            fontSize: ConstantSizes.fontSizeMd,
                            fontWeight: ConstantSizes.fontWeightRegular,
                          ),
                        ),
                        onChanged: (val) {
                          BlocProvider.of<BoundaryCubit>(context).updateName(val.toString());
                        },

                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(parentContext ?? context, MaterialPageRoute(builder: (context) {
                    return AddBoundaryView();
                  }));
                },
                child: const PlaceOption(optionText: "Locate on Map",
                    icon: FontAwesomeIcons.mapLocationDot,
                    iconSize: 26,
                    iconColor: ConstantColors.secondaryBackground,
                    backgroundColor: ConstantColors.white,
                    borderColor: ConstantColors.grey),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                padding: const EdgeInsets.all(
                    ConstantSizes.spaceBtwItems
                ),
                child: Row(
                  children: [
                    Text(
                      "Boundaries",
                      style: TextStyle(
                          fontSize: ConstantSizes.fontSizeMd,
                          fontWeight: ConstantSizes.fontWeightBold,
                          color: Colors.grey[500]
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder(builder: (context, state) {
                if (state is GetBoundariesLoading) {
                  return CircularProgressIndicator();
                }
                else if (state is GetBoundariesSuccess) {
                  return ListView(
                    children: [
                      ...state.boundaries.map((boundary) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AddBoundaryView.routeName);
                          },
                          child: PlaceOption(
                            optionText: boundary.name,
                            icon: FontAwesomeIcons.mapMarkerAlt,
                            iconSize: 26,
                            iconColor: ConstantColors.secondaryBackground,
                            backgroundColor: ConstantColors.white,
                            borderColor: ConstantColors.grey,
                          ),
                        );
                      }),
                    ],
                  );

                }
                else {
                  return Text("Error in fetching boundaries");
                }
              })
              // ...List.generate(3, (index) => PlaceOption(
              //   optionText: "Nearby location $index",
              //   icon: FontAwesomeIcons.mapLocationDot,
              //   iconSize: 26,
              //   iconColor: ConstantColors.secondaryBackground,
              //   backgroundColor: ConstantColors.white,
              //   borderColor: ConstantColors.grey,
              // ))
            ]
        ),
      );
  }
}
