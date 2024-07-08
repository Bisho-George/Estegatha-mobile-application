import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:estegatha/features/organization/presentation/view/setting/admin_setting_screen.dart';
import 'package:estegatha/features/organization/presentation/view/setting/member_setting_screen.dart';

class OrganizationSettingsScreen extends StatefulWidget {
  final int organizationId;

  const OrganizationSettingsScreen({super.key, required this.organizationId});

  @override
  State<OrganizationSettingsScreen> createState() =>
      _OrganizationSettingsScreenState();
}

class _OrganizationSettingsScreenState
    extends State<OrganizationSettingsScreen> {
  bool isOwner = false;

  @override
  void initState() {
    super.initState();
    context
        .read<OrganizationCubit>()
        .getOrganizationById(widget.organizationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            getProportionateScreenHeight(ConstantSizes.appBarHeight)),
        child: CustomAppBar(
          leadingIcon: Icons.arrow_back,
          leadingOnPressed: () => Navigator.pop(context, true),
          title: BlocBuilder<OrganizationCubit, OrganizationState>(
            builder: (context, state) {
              String appBarTitle = "";
              if (state is OrganizationDetailSuccess) {
                appBarTitle = state.organization.name!;
              }
              return Text(
                appBarTitle,
                style: TextStyle(
                  fontSize: SizeConfig.font20,
                  color: ConstantColors.primary,
                ),
              );
            },
          ),
          showBackArrow: false,
        ),
      ),
      body: BlocBuilder<OrganizationCubit, OrganizationState>(
        builder: (context, state) {
          if (state is OrganizationLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...'),
                ],
              ),
            );
          } else if (state is OrganizationDetailSuccess) {
            SizeConfig().init(context);
            isOwner = state.members!.any((member) =>
                member.userId ==
                    context.read<UserCubit>().getCurrentUser()?.id &&
                (member.role == 'OWNER' || member.role == 'ADMIN'));
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<OrganizationCubit>()
                    .getOrganizationById(widget.organizationId);
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: isOwner
                        ? OwnerSettingScreen(
                            organization: state.organization,
                            members: state.members!,
                          )
                        : MemberSettingScreen(
                            organization: state.organization,
                            members: state.members!,
                          ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: getProportionateScreenHeight(20)),
                  ),
                ],
              ),
            );
          } else if (state is OrganizationFailure) {
            return const Center(
                child: Text('Failed to load organization data'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
