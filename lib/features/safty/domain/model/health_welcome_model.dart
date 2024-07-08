import 'package:estegatha/utils/constant/image_strings.dart';

class HealthWelcomeModel{
  String imagePath;
  String title;
  HealthWelcomeModel(this.imagePath, this.title);
}
List<HealthWelcomeModel> healthWelcomeModelList = [
  HealthWelcomeModel(ConstantImages.healthTrackerImage1, 'Welcome to your personal health tracker'),
  HealthWelcomeModel(ConstantImages.healthTrackerImage2, 'Connect your Watch to Monitor everything from Estegatha'),
];