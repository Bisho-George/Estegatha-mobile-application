import 'package:estegatha/core/domain/model/contact_model.dart';
import 'package:estegatha/features/safty/presentation/pages/add_contact_page.dart';
import 'package:estegatha/features/safty/presentation/view_models/contact_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/contact_state.dart';
import 'package:estegatha/features/safty/presentation/widgets/contact_widget.dart';
import 'package:estegatha/utils/common/widgets/category_header_widget.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/loading_widget.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../widgets/add_contact_widget.dart';
import '../widgets/add_widget.dart';

class EmergencyContactPage extends StatelessWidget {
  EmergencyContactPage({super.key});

  static const String routeName = '/emergency-contact';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    BlocProvider.of<ContactCubit>(context).fetchContact();
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Emergency Contact',
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            color: ConstantColors.primary,
            onPressed: () {
              BlocProvider.of<ContactCubit>(context).fetchContact();
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                AddContactWidget(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddContactPage()));
                  },
                ),
                const CategoryHeaderWidget(name: 'Saved Contacts'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: BlocConsumer<ContactCubit, ContactState>(
              builder: (context, state) {
                return LoadingWidget(
                  loading: BlocProvider.of<ContactCubit>(context).isLoading,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount:
                        BlocProvider.of<ContactCubit>(context).contacts.length,
                    itemBuilder: (context, index) {
                      return ContactWidget(
                        contact: ContactModel(
                          name: BlocProvider.of<ContactCubit>(context)
                              .contacts[index]
                              .name,
                          phoneNumber: context
                              .read<ContactCubit>()
                              .contacts[index]
                              .phoneNumber,
                        ),
                      );
                    },
                  ),
                );
              },
              listener: (context, state) {
                if (state is ContactSuccessState) {
                  HelperFunctions.showCustomToast(
                    context: context,
                    title: const Text(
                      'Fetch contact success',
                      style: TextStyle(color: ConstantColors.primary),
                    ),
                    type: ToastificationType.success,
                    position: Alignment.bottomCenter,
                    duration: 2,
                    icon: const Icon(
                      Icons.check_circle_outline_rounded,
                      color: ConstantColors.primary,
                    ),
                    backgroundColor: ConstantColors.secondary,
                  );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(state.message),
                  //   ),
                  // );
                } else if (state is ContactFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
