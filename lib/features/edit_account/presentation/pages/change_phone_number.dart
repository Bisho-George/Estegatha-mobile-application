import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_cubit.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_phone_cubit.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_phone_state.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../../../organization/domain/models/member.dart';
import '../../../sign-in/presentation/veiw_models/user_cubit.dart';
class ChangePhonePage extends StatefulWidget {
  static const String routeName = '/change_phone';

  const ChangePhonePage({super.key});

  @override
  State<ChangePhonePage> createState() => _ChangePhonePageState();
}

class _ChangePhonePageState extends State<ChangePhonePage> {
  TextEditingController controller = TextEditingController();

  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return BlocConsumer<EditPhoneCubit, EditPhoneState>(
      builder: (context, state) {
        return LoadingWidget(
          loading: BlocProvider.of<EditPhoneCubit>(context).loading,
          child: Scaffold(
            appBar: CustomAppBar.buildAppBar(
              title: 'Edit Phone Number',
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  color: ConstantColors.primary,
                  onPressed: () {
                    if(isValid) {
                      FocusScope.of(context).unfocus();
                      BlocProvider.of<EditPhoneCubit>(context).editPhone();
                    }
                  },
                  padding: EdgeInsets.only(right: responsiveWidth(20)),
                ),
              ],
            ),
            body: LoadingWidget(
              loading: false,
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(vertical: responsiveHeight(ConstantSizes.md), horizontal: responsiveWidth(ConstantSizes.md)),
                child: IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'EG',
                  onChanged: (phone) {
                    BlocProvider.of<EditPhoneCubit>(context).phone = phone.completeNumber;
                    isValid = phone.isValidNumber();
                  },
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if(state is EditPhoneSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          BlocProvider.of<UserCubit>(context).setUser(state.newMember);
          BlocProvider.of<EditPhoneCubit>(context).phone = '';
          Navigator.pop(context);
        } else if(state is EditPhoneFailure) {
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