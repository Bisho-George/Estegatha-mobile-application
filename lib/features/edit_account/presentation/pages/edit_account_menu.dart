import 'package:estegatha/features/edit_account/domain/model/account_preferences.dart';
import 'package:estegatha/features/edit_account/presentation/pages/change_phone_number.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_cubit.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_state.dart';
import 'package:estegatha/features/edit_account/presentation/widgets/category_widget.dart';
import 'package:estegatha/features/edit_account/presentation/widgets/profile_widget.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_email.dart';
import 'change_password.dart';
class EditAccountMenu extends StatelessWidget {
  const EditAccountMenu({super.key});
  static const String routeName = 'EditAccountMenu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Account'),
      body: BlocConsumer<EditAccountCubit, EditAccountState>(
        builder: (context, state) {
          return LoadingWidget(
            loading: BlocProvider.of<EditAccountCubit>(context).loading,
            child: Column(
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
        },
        listener: (context, state) {
          if(state is EditAccountSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          } else if(state is EditAccountFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        }
      ),
    );
  }
}
