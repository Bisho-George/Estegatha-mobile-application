import 'package:estegatha/features/safty/presentation/pages/select_location_page.dart';
import 'package:estegatha/features/safty/presentation/view_models/location_feedback_cubit.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/category_header_widget.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../view_models/location_feedback_state.dart';
import '../widgets/location_quick_access_widget.dart';
import '../widgets/location_search_widget.dart';

class LocationFeedbackPage extends StatefulWidget {
  LocationFeedbackPage({super.key});

  static const String routeName = '/location-feedback';

  @override
  State<LocationFeedbackPage> createState() => _LocationFeedbackPageState();
}

class _LocationFeedbackPageState extends State<LocationFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<LocationFeedbackCubit, LocationFeedbackState>(
      builder: (context, state) {
        return LoadingWidget(
          loading: BlocProvider.of<LocationFeedbackCubit>(context).isLoading,
          child: Scaffold(
            appBar: CustomAppBar.buildAppBar(
              title: 'Location Feedback',
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: ConstantColors.primary,
                  ),
                  onPressed: () {
                    BlocProvider.of<LocationFeedbackCubit>(context).submitLocationFeedback();
                  },
                )
              ],
            ),
            body: Column(
              children: [
                const CategoryHeaderWidget(name: 'Quick access'),
                LocationQuickAccessWidget(
                  title: 'Use my current location',
                  iconPath: 'assets/current_location.png',
                  onTap: () {
                    Geolocator.getCurrentPosition().then((Position position) {
                      BlocProvider.of<LocationFeedbackCubit>(context).location = [
                        position.latitude,
                        position.longitude,
                      ];
                    });
                  },
                ),
                LocationQuickAccessWidget(
                  title: 'Locate on map',
                  iconPath: 'assets/locate_icon.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectLocationPage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: responsiveHeight(ConstantSizes.md),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(ConstantSizes.sm),
                  ),
                  child: TextField(
                    controller: BlocProvider.of<LocationFeedbackCubit>(context).feedbackController,
                    decoration: InputDecoration(
                      hintText: 'Type your feedback here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is LocationFeedbackSuccess) {
          HelperFunctions.showSnackBar(context, state.message);
        } else if (state is LocationFeedbackFailure) {
          HelperFunctions.showSnackBar(context, state.message);
        }
      },
    );
  }
}
