import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view/boarding_page.dart';
import 'package:estegatha/features/organization/presentation/view/join/join_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view_model/user_organizations_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/presentation/view_models/current_oragnization_cubit/current_organization_cubit.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  int? userId;
  Organization? currentOrganization;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadUserOrganizations();
  }

  Future<void> _loadUserOrganizations() async {
    await context.read<UserOrganizationsCubit>().getUserOrganizations(userId!);
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userCubit = BlocProvider.of<UserCubit>(context);
    final user = userCubit.getCurrentUser();

    setState(() {
      username = user?.username;
      userId = user?.id;
    });

    if (userId != null) {
      await context
          .read<UserOrganizationsCubit>()
          .getUserOrganizations(userId!);
      _loadCurrentOrganization();
    }
  }

  Future<void> _loadCurrentOrganization() async {
    final prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getInt('currentOrganizationId');
    if (organizationId != null && userId != null) {
      final organizationsCubit = context.read<UserOrganizationsCubit>();
      if (organizationsCubit.state is UserOrganizationsSuccess) {
        final organizations =
            (organizationsCubit.state as UserOrganizationsSuccess)
                .organizations;
        final organization = organizations.firstWhere(
          (org) => org.id == organizationId,
          orElse: () => Organization(id: -1, name: "Unknown"),
        );
        setState(() {
          currentOrganization = organization.id == -1 ? null : organization;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadUserOrganizations();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          BlocBuilder<UserOrganizationsCubit, UserOrganizationsState>(
            builder: (context, userOrgState) {
              if (userOrgState is UserOrganizationsSuccess) {
                final organizations = userOrgState.organizations;
                return BlocBuilder<CurrentOrganizationCubit,
                    CurrentOrganizationState>(
                  builder: (context, currentOrgState) {
                    final currentOrganization = organizations.firstWhere(
                      (org) => org == currentOrgState,
                      orElse: () => organizations.first,
                    );
                    return DropdownButton<Organization>(
                      value: currentOrganization,
                      onChanged: (Organization? newOrganization) {
                        if (newOrganization != null) {
                          context
                              .read<CurrentOrganizationCubit>()
                              .setCurrentOrganization(newOrganization);
                        }
                      },
                      items: organizations.map<DropdownMenuItem<Organization>>(
                        (Organization organization) {
                          return DropdownMenuItem<Organization>(
                            value: organization,
                            child: Text(organization.name!),
                          );
                        },
                      ).toList(),
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Home Page'),
            Text("Hello $username"),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: OrganizationBoardingPage(
                        name: username!,
                      ),
                      withNavBar: false,
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.create),
                      SizedBox(width: 8),
                      Text('Create organization'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JoinOrganizationPage(),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text('Join organization'),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child:
                  BlocBuilder<UserOrganizationsCubit, UserOrganizationsState>(
                builder: (context, state) {
                  if (state is UserOrganizationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserOrganizationsFailure) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is UserOrganizationsSuccess) {
                    final organizations = state.organizations;
                    return ListView.builder(
                      itemCount: organizations.length,
                      itemBuilder: (context, index) {
                        final organization = organizations[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrganizationDetailPage(
                                  organizationId: organization.id!),
                            ),
                          ),
                          child: ListTile(
                            title: Text(organization.name!),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("No organizations found.");
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              child: CustomElevatedButton(
                labelText: 'Logout',
                onPressed: () async {
                  BlocProvider.of<UserCubit>(context).logout(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
