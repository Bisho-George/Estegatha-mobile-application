
import 'package:estegatha/features/add_place/domain/entities/organization_boundary_entity.dart';
import 'package:estegatha/features/add_place/presentation/view_models/boundary_cubit.dart';
import 'package:estegatha/features/add_place/presentation/views/widgets/custom_google_maps.dart';
import 'package:estegatha/features/home/presentation/views/home_view.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../responsive/size_config.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';

class AddBoundaryView extends StatelessWidget {
  static const String routeName = '/add_boundary';

  const AddBoundaryView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add boundary',
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
          TextButton(onPressed: () {
            num organizationId = BlocProvider.of<CurrentOrganizationCubit>(context).currentOrganization.id;
            String name = BlocProvider.of<BoundaryCubit>(context).name;
            double lat = BlocProvider.of<BoundaryCubit>(context).lat;
            double lang = BlocProvider.of<BoundaryCubit>(context).lang;
            double radius = BlocProvider.of<BoundaryCubit>(context).radius;
            BlocProvider.of<BoundaryCubit>(context).addBoundary(organizationId, OrganizationBoundaryEntity(name: name, lat: lat, lang: lang, radius: radius));
            Navigator.pushNamed(context, HomeView.routeName);
          }, child: const Text('Save')),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.2,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.all(
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
                          onChanged: (value) {
                            BlocProvider.of<BoundaryCubit>(context).updateName(value.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: ConstantSizes.defaultSpace),
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


