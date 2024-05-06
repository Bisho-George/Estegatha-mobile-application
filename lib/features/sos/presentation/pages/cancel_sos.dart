import 'package:estegatha/features/sos/presentation/pages/cancel_sos_pin.dart';
import 'package:estegatha/features/sos/presentation/widgets/cancel_alert_button.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class CancelSos extends StatelessWidget {
  const CancelSos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFE7370),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            'we will send an alert to your organization and '
            'emergency contacts when the countdown reaches zero.',
            style: Styles.getDefaultWhite(fontSize: ConstantSizes.fontSizeLg),
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(
          flex: 40,
        ),
        CancelAlertButton(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CancelSosPin(),
              ),
            );
          },
        ),
        Spacer(
          flex: 50,
        ),
        Spacer(
          flex: 30,
        ),
      ]),
    );
  }
}
