import 'package:estegatha/core/work_manager/work_manager.dart';
import 'package:estegatha/features/safety/presentation/view_model/user_health_cubit.dart';
import 'package:estegatha/features/safty/data/api/fitness_connect_api.dart';
import 'package:estegatha/features/safty/domain/model/health_metrices_model.dart';
import 'package:estegatha/features/safty/presentation/view_models/fitness_connect_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/fitness_data_state.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health/health.dart';

import '../../../../utils/common/widgets/custom_app_bar.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../view_models/fitness_data_cubit.dart';
import '../widgets/health_data_widget.dart';
import '../widgets/health_metrices_widget.dart';
import '../widgets/heart_rate_widget.dart';

class HealthTrackerDataPage extends StatefulWidget {
  const HealthTrackerDataPage({super.key});

  @override
  State<HealthTrackerDataPage> createState() => _HealthTrackerDataPageState();
}

class _HealthTrackerDataPageState extends State<HealthTrackerDataPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FitnessDataCubit>(context).fetchData();
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Health Tracker',
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_account),
            onPressed: () async {
              BlocProvider.of<FitnessDataCubit>(context).changeAccount();
            },
            color: ConstantColors.primary,
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              BlocProvider.of<FitnessDataCubit>(context).fetchData();
              SchedualWork().schedualFitnessWork();
            },
            color: ConstantColors.primary,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<FitnessDataCubit, FitnessDataState>(
                builder: (context, state) {
                  return LoadingWidget(
                    loading: BlocProvider
                        .of<FitnessDataCubit>(context)
                        .loading,
                    child: HealthDataWidget(
                      healthMetrices: BlocProvider.of<FitnessDataCubit>(context).healthMetrices,
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is FitnessDataSuccess) {
                    HelperFunctions.showSnackBar(context, state.message);
                  } else if (state is FitnessDataFailure) {
                    HelperFunctions.showSnackBar(context, state.message);
                  }
                }
            ),
          ),
          Positioned(
            bottom: responsiveHeight(120),
            right: responsiveWidth(20),
            child: SvgPicture.asset(ConstantImages.healthTrackerCharacter),
          ),
        ],
      ),
    );
  }
}
