import 'package:estegatha/features/organization/presentation/view/create/invite_to_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/seggustion_name.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateOrganizationPage extends StatefulWidget {
  static const String id = 'create_organization_page';

  const CreateOrganizationPage({super.key});

  @override
  CreateOrganizationPageState createState() => CreateOrganizationPageState();
}

class CreateOrganizationPageState extends State<CreateOrganizationPage> {
  String organizationName = '';
  String selectedName = '';
  final quickNames = [
    "Family",
    "Friends",
    "Extended Family",
    "Field Trip Group",
    "University"
  ];

  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrganizationCubit, OrganizationState>(
      listener: (context, state) {
        if (state is OrganizationLoading) {
          isLoading = true;
        } else if (state is OrganizationCreationSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return InviteToOrganizationPage(
                  name: BlocProvider.of<OrganizationCubit>(context)
                      .state
                      .organization!
                      .name,
                );
              },
            ),
          );
        } else if (state is OrganizationFailure) {
          HelperFunctions.showSnackBar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: context.select(
            (OrganizationCubit cubit) => cubit.state is OrganizationLoading),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
              leading: IconButton(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              iconTheme: const IconThemeData(
                color: ConstantColors.primary,
              ),
              flexibleSpace: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: ConstantColors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: ConstantColors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: ConstantSizes.defaultSpace * 2,
                            right: ConstantSizes.defaultSpace * 2,
                            top: 20,
                          ),
                          child: Form(
                            child: SizedBox(
                              height: ConstantSizes.appBarHeight * 2,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Name your organization',
                                  hintStyle: TextStyle(
                                    color: ConstantColors.darkGrey,
                                    fontSize: ConstantSizes.fontSizeLg,
                                    fontWeight: ConstantSizes.fontWeightRegular,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: ConstantColors.primary,
                                  fontSize: ConstantSizes.fontSizeLg,
                                ),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      organizationName = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const ShapeDecoration(
                            color: ConstantColors.primary,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6,
                        top: 6,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const ShapeDecoration(
                            color: Colors.grey,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ConstantSizes.sm),
                SizedBox(
                  width: 180,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Choose a name for your new organization",
                    style: TextStyle(
                      color: ConstantColors.darkGrey,
                      fontSize: ConstantSizes.fontSizeMd,
                    ),
                  ),
                ),
                SizedBox(height: ConstantSizes.spaceBtwItems),
                const SectionHeading(
                  title: "Suggestions",
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: organizationName.isNotEmpty
                          ? [
                              SuggestionItem(
                                name: organizationName,
                                onTap: () {
                                  selectedName = organizationName;
                                  BlocProvider.of<OrganizationCubit>(context)
                                      .createOrganization(
                                    context,
                                    name: selectedName,
                                  );
                                },
                              )
                            ]
                          : quickNames
                              .map(
                                (name) => SuggestionItem(
                                  name: name,
                                  onTap: () {
                                    selectedName = name;
                                    BlocProvider.of<OrganizationCubit>(context)
                                        .createOrganization(
                                      context,
                                      name: selectedName,
                                    );
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
