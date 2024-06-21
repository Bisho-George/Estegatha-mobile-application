import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view/boarding_page.dart';
import 'package:estegatha/features/organization/presentation/view/join/join_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home_page';

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    final user = userCubit.getCurrentUser();
    final userId = user?.id;

    Future<void> deleteUserFromPreferences() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('user');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home Page',
            ),
            Text("You're logged in, all functions are available now."),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const OrganizationBoardingPage(
                        name: 'Dummy',
                      ),
                      // screen: const FinalJoinOrganizationPage(orgId: 7),
                      withNavBar: false,
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         const OrganizationBoardingPage(),
                    //   ),
                    // );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.create),
                      SizedBox(
                          width:
                              8), // Add some space between the icon and the text
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
                      SizedBox(
                          width:
                              8), // Add some space between the icon and the text
                      Text('Join organization'),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Join organization'),
                  if (userId == null) ...[
                    const Text("User not logged in."),
                  ] else ...[
                    Expanded(
                      child: FutureBuilder<List<Organization>>(
                        future: BlocProvider.of<UserCubit>(context)
                            .getUserOrganizations(context, userId!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            final organizations = snapshot.data!;
                            return ListView.builder(
                              itemCount: organizations.length,
                              itemBuilder: (context, index) {
                                final organization = organizations[index];
                                return InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrganizationDetailPage(
                                        organizationId: organization.id!,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(organization.name!),
                                    // Add other organization details here
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
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16), // Add some space between the buttons
            SizedBox(
              width: 300,
              child: CustomElevatedButton(
                labelText: 'Logout',
                onPressed: () async {
                  await deleteUserFromPreferences();
                  BlocProvider.of<UserCubit>(context).logout();
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SignInPage(),
                  //   ),
                  // );
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: SignInPage(),
                    withNavBar: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
