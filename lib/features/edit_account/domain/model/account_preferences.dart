import 'package:estegatha/features/edit_account/presentation/widgets/preference_widget.dart';
import 'package:flutter/cupertino.dart';

class AccountPreferences{
  AccountPreferences({required this.propertyName, required this.propertyAction});
  String propertyName;
  void Function() propertyAction;
}
class PreferencesCategory{
  PreferencesCategory({required this.categoryName, required this.preferences});
  String categoryName;
  List<AccountPreferences> preferences;
}