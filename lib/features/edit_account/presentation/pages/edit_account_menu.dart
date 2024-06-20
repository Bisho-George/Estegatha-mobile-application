import 'package:estegatha/features/edit_account/domain/model/account_preferences.dart';
import 'package:estegatha/features/edit_account/presentation/pages/change_phone_number.dart';
import 'package:estegatha/features/edit_account/presentation/widgets/category_widget.dart';
import 'package:estegatha/features/edit_account/presentation/widgets/profile_widget.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'change_email.dart';
import 'change_password.dart';
class EditAccountMenu extends StatelessWidget {
  const EditAccountMenu({super.key});
  static const String routeName = 'EditAccountMenu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Account'),
      body: Column(
        children: [
          ProfileWidget(userName: "Ahmed"),
          CategoryWidget(
            name: 'Account details',
            preferences: [
              AccountPreferences(propertyName: 'Edit Phone Number', propertyAction: (){
                Navigator.pushNamed(context, ChangePhoneNumber.routeName);
              }),
              AccountPreferences(propertyName: 'Change Password', propertyAction: (){
                Navigator.pushNamed(context, ChangePassword.routeName);
              })
            ],
          ),
          CategoryWidget(
            name: 'Account management',
            preferences: [
              AccountPreferences(propertyName: 'Delete Account', propertyAction: (){

              }),
            ],
          ),
        ],
      ),
    );
  }
}
