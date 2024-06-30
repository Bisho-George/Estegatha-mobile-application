import 'package:estegatha/core/domain/model/contact_model.dart';
import 'package:estegatha/features/safty/presentation/view_models/add_contact_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/add_contact_state.dart';
import 'package:estegatha/features/safty/presentation/view_models/cotact_cubit.dart';
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
  TextEditingController controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    FocusNode node = FocusNode();
    return BlocConsumer<AddContactCubit, AddContactState>(
      builder: (context, state) {
        return LoadingWidget(
          loading: BlocProvider.of<ContactCubit>(context).isLoading,
          child: Scaffold(
            appBar: CustomAppBar.buildAppBar(title: 'Add Contact', actions: [
              IconButton(
                icon: const Icon(Icons.check),
                color: ConstantColors.primary,
                onPressed: () {
                  BlocProvider.of<ContactCubit>(context).addContact(ContactModel(
                      name: controller.text, phoneNumber: phoneController.text));
                  Navigator.pop(context);
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
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                const CategoryHeaderWidget(name: 'Phone Number'),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(ConstantSizes.lg),
                    vertical: responsiveHeight(ConstantSizes.md),
                  ),
                  child: IntlPhoneField(
                    showCursor: false,
                    controller: phoneController,
                    initialCountryCode: 'EG',
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.pop(context);
        }
      }
    );
  }
}
