import 'package:estegatha/features/safty/presentation/pages/health_tracker_data_page.dart';
import 'package:estegatha/features/safty/presentation/widgets/sign_in_google_widget.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/ui/with_foreground_task.dart';

import '../../../../utils/common/widgets/custom_app_bar.dart';
import '../view_models/fitness_connect_cubit.dart';
import '../view_models/fitness_connect_state.dart';

class HealthTrackerConnectPage extends StatelessWidget {
  const HealthTrackerConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WithForegroundTask(
      child: Scaffold(
        appBar: CustomAppBar.buildAppBar(title: 'Health Tracker'),
        body: BlocConsumer<FitnessConnectCubit, FitnessConnectState>(
            builder: (context, state) {
          return LoadingWidget(
            loading: BlocProvider.of<FitnessConnectCubit>(context).loading,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage(ConstantImages.healthTrackerImage3),
                    width: double.infinity,
                    height: responsiveHeight(400),
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: responsiveHeight(100),
                  ),
                  SignInGoogleWidget(
                    onTap: () {
                      BlocProvider.of<FitnessConnectCubit>(context).connect();
                    },
                  ),
                ],
              ),
            ),
          );
        }, listener: (context, state) {
          if (state is FitnessConnectSuccess) {
            HelperFunctions.showSnackBar(context, state.message);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HealthTrackerDataPage()));
          } else if (state is FitnessConnectFailure) {
            HelperFunctions.showSnackBar(context, state.message);
          }
        }),
      ),
    );
  }
}
