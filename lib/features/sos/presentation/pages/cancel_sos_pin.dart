import 'package:estegatha/features/sos/presentation/view_models/cubit/cancel_sos_cubit.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/cancel_sos_state.dart';
import 'package:estegatha/features/sos/presentation/widgets/pin_input.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

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
                const Spacer(
                  flex: 50,
                ),
                PinInput(
                  onChange: (pin) {
                    if (pin.length == 4) {
                      BlocProvider.of<CancelSosCubit>(context).cancelSos(pin);
                    }
                  },
                ),
                const Spacer(
                  flex: 100,
                ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is CancelSosFailure) {
          HelperFunctions.showSnackBar(context, state.message!);
        } else if (state is CancelSosSuccess) {
          HelperFunctions.showSnackBar(
              context, 'SOS request has been canceled');
          GetStorage().write('status', 'safe');
          TextEditingController controller = TextEditingController();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: const Text(
                        'Please give us our problem type for analysis'),
                    content: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your problem type',
                      ),
                      controller: controller,
                    ),
                    actions: [
                      CustomElevatedButton(
                        onPressed: () {
                          if(controller.text.isEmpty){
                            return;
                          }
                          BlocProvider.of<CancelSosCubit>(context)
                              .sendFeedback(controller.text);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        labelText: 'Send',
                      ),
                    ],
                  ));

        }
      }),
    );
  }
}
