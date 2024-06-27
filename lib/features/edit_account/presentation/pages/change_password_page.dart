import 'package:estegatha/features/edit_account/presentation/view_models/edit_password_cubit.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_password_state.dart';
import 'package:estegatha/features/edit_account/presentation/widgets/custom_password_widget.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChangePassword extends StatelessWidget {
  static const String routeName = '/change_password';
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return BlocConsumer<EditPasswordCubit, EditPasswordState>(
      builder: (context, state) {
        return LoadingWidget(
          loading: BlocProvider.of<EditPasswordCubit>(context).loading,
          child: Scaffold(
            appBar: CustomAppBar.buildAppBar(
              title: 'Change Password',
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  color: ConstantColors.primary,
                  onPressed: () {
                    BlocProvider.of<EditPasswordCubit>(context).editPassword();
                    FocusScope.of(context).unfocus();
                  },
                  padding: EdgeInsets.only(right: responsiveWidth(ConstantSizes.lg)),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(responsiveWidth(ConstantSizes.lg)),
              width: double.infinity,
              height: responsiveHeight(600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomPasswordWidget(hint: 'Current Password', controller: BlocProvider.of<EditPasswordCubit>(context).currentPasswordController),
                  CustomPasswordWidget(hint: 'New Password', controller: BlocProvider.of<EditPasswordCubit>(context).newPasswordController),
                  CustomPasswordWidget(hint: 'Re-type New Password', controller: BlocProvider.of<EditPasswordCubit>(context).rePasswordController),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children :
                    [
                      Padding(
                        padding: EdgeInsets.only(bottom: responsiveHeight(ConstantSizes.sm)),
                        child: Text('Your new password must have:',
                          style: Styles.getDefaultPrimary(weight: ConstantSizes.fontWeightBold),
                        ),
                      ),
                      Text('At least 8 characters',
                        style: Styles.getDefaultPrimary(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if(state is EditPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.pop(context);
        } else if(state is EditPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      }
    );
  }
}