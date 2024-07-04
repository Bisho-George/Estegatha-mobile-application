import 'package:estegatha/features/edit_account/domain/model/account_preferences.dart';
import 'package:estegatha/features/edit_account/presentation/pages/change_phone_number.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_cubit.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_state.dart';
import 'package:estegatha/features/edit_account/presentation/widgets/category_widget.dart';
import 'package:estegatha/features/edit_account/presentation/widgets/profile_widget.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_email.dart';
import 'change_password_page.dart';

class EditAccountMenu extends StatefulWidget {
  BuildContext? parentContext;
  EditAccountMenu({super.key, this.parentContext});

  static const String routeName = 'EditAccountMenu';

  @override
  State<EditAccountMenu> createState() => _EditAccountMenuState();
}

class _EditAccountMenuState extends State<EditAccountMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Account'),
      body: LoadingWidget(
        loading: false,
        child: Column(
          children: [
            ProfileWidget(
                userName: context.read<UserCubit>().getCurrentUser()!.username),
            CategoryWidget(
              name: 'Account details',
              preferences: [
                AccountPreferences(
                    propertyName: 'Edit Phone Number',
                    propertyAction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePhonePage()));
                    }),
                AccountPreferences(
                    propertyName: 'Change Password',
                    propertyAction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
