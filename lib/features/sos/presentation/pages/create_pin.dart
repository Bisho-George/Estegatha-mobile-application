import 'package:estegatha/features/organization/presentation/view/create/create_organization_page.dart';
import 'package:estegatha/features/sos/presentation/pages/cancel_sos.dart';
import 'package:estegatha/features/sos/presentation/pages/cancel_sos_pin.dart';
import 'package:estegatha/features/sos/presentation/widgets/pin_field.dart';
import 'package:estegatha/features/sos/presentation/widgets/pin_input.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});
  static const String routeName = '/sos/create-pin';

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  double opacity = 0.6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar('SOS'),
      body: Column(
        children: [
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
            child: Text(
              'let’s choose your 4-digit PIN now...',
              textAlign: TextAlign.center,
              style: Styles.getDefaultPrimary(fontSize: 16).copyWith(
                color: Colors.black,
              )
            ),
          ),
          Spacer(
            flex: 20,
          ),
          PinInput(
            onChange: (pin){
              if(pin.length == 4) {
                setState(() {
                  opacity = 1;
                });
              } else if(pin.length < 4){
                setState(() {
                  opacity = 0.6;
                });
              }
            },
          ),
          Spacer(
            flex: 80,
          ),
          Opacity(
            opacity: opacity,
            child: CustomElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CancelSos()));
                },
                labelText: 'Save PIN',
            ),
          ),
          Spacer(
            flex: 20,
          ),
        ]
      ),
    );
  }
}
