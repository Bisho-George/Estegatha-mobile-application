import 'package:estegatha/utils/constant/image_strings.dart';

import '../../features/sos_alert/presentation/views/widgets/sos_instruction.dart';

class SosAlertContent {
  final String sosImage;
  final String sosDescription;
  String? buttonText;
  List<SosInstruction>? sosInstruction;

  SosAlertContent({
    required this.sosImage,
    required this.sosDescription,
    this.buttonText,
    this.sosInstruction,
  });
}

List<SosAlertContent> contents = [
  SosAlertContent(
    sosImage: ConstantImages.sosAlert1,
    sosDescription: "Use the Estegatha SOS button when your feel unsafe",
    buttonText: "Next",
    sosInstruction: [
      SosInstruction(instruction: "Walking alone at night"),
      SosInstruction(instruction: "Present at an active issue"),
      SosInstruction(instruction: "Having a medical emergency"),
    ],
  ),
  SosAlertContent(
    sosImage: ConstantImages.sosAlert2,
    sosDescription: "Hold down the SOS button if you feel unsafe or think you might need help",
  ),
  SosAlertContent(
    sosImage: ConstantImages.sosAlert3,
    sosDescription: "Release the button to silently notify your organization and emergency contacts",
  ),
  SosAlertContent(
    sosImage: ConstantImages.sosAlert4,
    sosDescription: "If you’re OK, enter your PIN code and we’ll cancel your SOS",
    buttonText: "Setup pin "
  ),


];
