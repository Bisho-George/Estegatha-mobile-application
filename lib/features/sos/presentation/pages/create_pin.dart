import 'package:estegatha/features/organization/presentation/view/boarding_page.dart';
import 'package:estegatha/features/organization/presentation/view/create/create_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/sos/presentation/pages/cancel_sos.dart';
import 'package:estegatha/features/sos/presentation/pages/cancel_sos_pin.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/create_pin_cubit.dart';
import 'package:estegatha/features/sos/presentation/widgets/pin_field.dart';
import 'package:estegatha/features/sos/presentation/widgets/pin_input.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_models/cubit/create_pin_status.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});

  static const String routeName = '/sos/create-pin';

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'SOS'),
      body: BlocConsumer<CreatePinCubit, CreatePinStatus>(
        builder: (context, status) {
          if (status is CreatePinLoading)
            return Center(child: CircularProgressIndicator());
          else {
            return Column(children: [
              Container(
                color: ConstantColors.primary,
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                child: Text(
                  'Create PIN',
                  style: Styles.getDefaultWhite(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('let’s choose your 4-digit PIN now...',
                    textAlign: TextAlign.center,
                    style: Styles.getDefaultPrimary(fontSize: 16).copyWith(
                      color: Colors.black,
                    )),
              ),
              Spacer(
                flex: 20,
              ),
              PinInput(
                onChange: (pin) {
                  BlocProvider.of<CreatePinCubit>(context).pin = pin;
                  if (pin.length == 4) {
                    setState(() {
                      BlocProvider.of<CreatePinCubit>(context).opacity = 1;
                    });
                  } else if (pin.length < 4) {
                    setState(() {
                      BlocProvider.of<CreatePinCubit>(context).opacity = 0.6;
                    });
                  }
                },
              ),
              Spacer(
                flex: 80,
              ),
              Opacity(
                opacity: BlocProvider.of<CreatePinCubit>(context).opacity,
                child: CustomElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CreatePinCubit>(context).sendPin();
                  },
                  labelText: 'Save PIN',
                ),
              ),
              Spacer(
                flex: 20,
              ),
            ]);
          }
        },
        listener: (context, state) {
          if (state is CreatePinSuccess) {
            Navigator.pushNamed(context, SendSos.routeName);
          } else if (state is CreatePinFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
      ),
    );
  }
}
