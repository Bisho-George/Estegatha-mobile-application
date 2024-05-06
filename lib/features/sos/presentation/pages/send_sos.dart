import 'package:estegatha/features/sos/presentation/pages/cancel_sos.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common/styles/text_styles.dart';

class SendSos extends StatelessWidget {
  const SendSos({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar('SOS'),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 50,
            ),
            CircleAvatar(
              radius: 115,
              backgroundColor: ConstantColors.borderSecondary,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CancelSos(),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: ConstantColors.primary,
                  child: Text(
                    'Tap to send SOS',
                    style: Styles.getWhiteMedium(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ConstantColors.primary,
                  child: Text(
                    'A',
                    style: Styles.getDefaultWhite(),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ConstantColors.primary,
                  child: Text(
                    'B',
                    style: Styles.getDefaultWhite(),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ConstantColors.primary,
                  child: Text(
                    'A',
                    style: Styles.getDefaultWhite(),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ConstantColors.primary,
                  child: Text(
                    'E',
                    style: Styles.getDefaultWhite(),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 5,
            ),
            Text(
              'Your SOS will be sent to 4 people',
              style: Styles.getDefaultPrimary(
                fontSize: ConstantSizes.fontSizeMd
              ),
            ),
            Spacer(
              flex: 30,
            ),
          ],
        ),
      ),
    );
  }
}
