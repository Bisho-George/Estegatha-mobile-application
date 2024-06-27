import 'package:estegatha/core/domain/model/contact_model.dart';
import 'package:estegatha/features/safty/presentation/pages/add_contact_page.dart';
import 'package:estegatha/features/safty/presentation/view_models/cotact_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/cotact_state.dart';
import 'package:estegatha/features/safty/presentation/widgets/contact_widget.dart';
import 'package:estegatha/utils/common/widgets/category_header_widget.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/add_contact_widget.dart';
import '../widgets/add_widget.dart';

class EmergencyContactPage extends StatelessWidget {
  EmergencyContactPage({super.key});

  static const String routeName = '/emergency-contact';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    context.read<ContactCubit>().fetchContact();
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Emergency Contact'),
      body: BlocConsumer<ContactCubit, ContactState>(
        builder: (context, state) {
          return LoadingWidget(
            loading: context.read<ContactCubit>().isLoading,
            child: Column(
              children: [
                AddContactWidget(
                  onTap: () {
                    Navigator.pushNamed(context, AddContactPage.routeName);
                  },
                ),
                const CategoryHeaderWidget(name: 'Saved Contacts'),
                Expanded(
                  child: ListView.builder(
                    itemCount: context.read<ContactCubit>().contacts.length,
                    itemBuilder: (context, index) {
                      return ContactWidget(
                        contact: ContactModel(
                          name: context.read<ContactCubit>().contacts[index].name,
                          phoneNumber: context.read<ContactCubit>().contacts[index].phoneNumber,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is ContactFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        }
      ),
    );
  }
}
