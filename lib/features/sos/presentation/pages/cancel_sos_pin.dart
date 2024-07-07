import 'package:estegatha/features/home/presentation/views/home_view.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/cancel_sos_cubit.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/cancel_sos_state.dart';
import 'package:estegatha/features/sos/presentation/widgets/pin_field.dart';
import 'package:estegatha/features/sos/presentation/widgets/pin_input.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main_menu.dart';
import '../../../../utils/common/styles/text_styles.dart';
class CancelSosPin extends StatelessWidget {
  const CancelSosPin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'SOS'),
      body: BlocConsumer<CancelSosCubit, CancelSosState>(
        builder: (context, state) {
          return LoadingWidget(
            loading: BlocProvider.of<CancelSosCubit>(context).isLoading,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Enter your pin to cancel',
                      style: Styles.getPrimaryMedium(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'If no PIN entered, your SOS and location will be sent to your organization and emergency contacts.',
                      style: Styles.getDefaultPrimary(
                        fontSize: ConstantSizes.fontSizeLg,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(
                    flex: 50,
                  ),
                  PinInput(
                    onChange: (pin) {
                      if (pin.length == 4) {
                        BlocProvider.of<CancelSosCubit>(context).cancelSos(pin);
                      }
                    },
                  ),
                  Spacer(
                    flex: 100,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is CancelSosFailure) {
            HelperFunctions.showSnackBar(context, state.message!);
            Navigator.popUntil(context, (route) => route is MainNavMenu);
          }
          else if(state is CancelSosSuccess){
            HelperFunctions.showSnackBar(context, 'SOS request has been canceled');
          }
        }
      ),
    );
  }
}
