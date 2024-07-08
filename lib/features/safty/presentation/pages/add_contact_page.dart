import 'package:estegatha/constants.dart';
import 'package:estegatha/core/domain/model/contact_model.dart';
import 'package:estegatha/features/safty/presentation/view_models/add_contact_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/add_contact_state.dart';
import 'package:estegatha/features/safty/presentation/view_models/contact_cubit.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/category_header_widget.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../responsive/size_config.dart';
import '../../../../utils/constant/sizes.dart';

class AddContactPage extends StatelessWidget {
  AddContactPage({super.key});

  static const String routeName = '/add-contact';

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    var controller = TextEditingController();
    return BlocConsumer<AddContactCubit, AddContactState>(
      builder: (context, state) {
        return LoadingWidget(
          loading: BlocProvider.of<AddContactCubit>(context).isloding,
          child: Scaffold(
            appBar: CustomAppBar.buildAppBar(title: 'Add Contact', actions: [
              IconButton(
                icon: const Icon(Icons.check),
                color: ConstantColors.primary,
                onPressed: () {
                  BlocProvider.of<AddContactCubit>(context).addContact();
                },
              ),
            ]),
            body: Column(
              children: [
                const CategoryHeaderWidget(name: 'Name'),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: responsiveWidth(ConstantSizes.lg),
                    right: responsiveWidth(ConstantSizes.lg),
                    bottom: responsiveHeight(ConstantSizes.md),
                  ),
                  child: TextField(
                    style: Styles.getDefaultPrimary(
                        weight: ConstantSizes.fontWeightBold),
                    controller: BlocProvider.of<AddContactCubit>(context).controller,
                    textAlignVertical: TextAlignVertical.center,
                    showCursor: true,
                    cursorColor: ConstantColors.primary,
                  ),
                ),
                const CategoryHeaderWidget(name: 'Phone Number'),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(ConstantSizes.lg),
                    vertical: responsiveHeight(ConstantSizes.md),
                  ),
                  child: IntlPhoneField(
                    showCursor: true,
                    initialCountryCode: 'EG',
                    onChanged: (phone) {
                      BlocProvider.of<AddContactCubit>(context).phone = phone.completeNumber;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddContactFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        else if (state is AddContactSuccess) {
          context.read<ContactCubit>().addContact(state.contactModel);
          Navigator.pop(context);
        }
      }
    );
  }
}
