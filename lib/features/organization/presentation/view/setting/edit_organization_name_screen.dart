import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditOrganizationName extends StatefulWidget {
  Organization organization;
  EditOrganizationName({super.key, required this.organization});

  @override
  _EditOrganizationNameState createState() => _EditOrganizationNameState();
}

class _EditOrganizationNameState extends State<EditOrganizationName> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back,
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        title: const Text(
          'Edit Organization Name',
          style: TextStyle(color: ConstantColors.primary),
        ),
        showBackArrow: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: getProportionateScreenHeight(ConstantSizes.defaultSpace)),
          child: SizedBox(
            width: getProportionateScreenWidth(320),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomTextField(
                    initialValue: widget.organization.name,
                    labelText: "Organization Name",
                    onChanged: (value) {
                      _name = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the organization name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(
                        ConstantSizes.defaultSpace),
                  ),
                  CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          context.read<OrganizationCubit>().updateOrganization(
                              context,
                              widget.organization.id!,
                              widget.organization,
                              _name,
                              widget.organization.type);
                          Navigator.pop(context);
                        }
                      },
                      labelText: "Save"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
