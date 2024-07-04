import 'package:estegatha/features/organization/presentation/view/create/invite_to_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/seggustion_name.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });

          if (state is OrganizationCreationSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => InviteToOrganizationPage(
                  name: state.organization.name!,
                  organizationCode: state.organization.organizationCode!,
                ),
              ),
            );
          } else if (state is OrganizationFailure) {
            HelperFunctions.showSnackBar(context, state.errMessage);
          }
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(getProportionateScreenHeight(85)),
            child: AppBar(
              leading: IconButton(
                icon: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(ConstantSizes.md)),
                  child: const Icon(Icons.arrow_back),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              iconTheme: const IconThemeData(
                color: ConstantColors.primary,
              ),
              flexibleSpace: Padding(
                padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(ConstantSizes.md)),
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
                            left: getProportionateScreenWidth(
                                ConstantSizes.defaultSpace * 2),
                            right: getProportionateScreenWidth(
                                ConstantSizes.defaultSpace * 2),
                            top: getProportionateScreenHeight(ConstantSizes.md),
                          ),
                          child: Form(
                            key: formKey,
                            child: SizedBox(
                              height: getProportionateScreenHeight(
                                      ConstantSizes.appBarHeight) *
                                  1.2,
                              child: TextFormField(
                                maxLines: 3,
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
                                    fontSize: SizeConfig.font20,
                                    fontWeight: ConstantSizes.fontWeightRegular,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: ConstantColors.primary,
                                  fontSize: SizeConfig.font20,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    organizationName = value;
                                  });
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
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(ConstantSizes.md)),
            child: Column(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(22),
                  height: getProportionateScreenHeight(22),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: getProportionateScreenWidth(20),
                          height: getProportionateScreenHeight(20),
                          decoration: const ShapeDecoration(
                            color: ConstantColors.primary,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: getProportionateScreenWidth(6),
                        top: getProportionateScreenHeight(6),
                        child: Container(
                          width: getProportionateScreenWidth(8),
                          height: getProportionateScreenHeight(8),
                          decoration: const ShapeDecoration(
                            color: Colors.grey,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: getProportionateScreenHeight(ConstantSizes.sm)),
                SizedBox(
                  width: getProportionateScreenWidth(180),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Choose a name for your new organization",
                    style: TextStyle(
                      color: ConstantColors.darkGrey,
                      fontSize: SizeConfig.font18,
                    ),
                  ),
                ),
                SizedBox(
                    height: getProportionateScreenHeight(
                        ConstantSizes.spaceBtwItems)),
                const SectionHeading(title: "Suggestions"),
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
