import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view/boarding_page.dart';
import 'package:estegatha/features/organization/presentation/view/join/join_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/user_organizations_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatefulWidget {
//   static const String id = 'home_page';

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String? username;
//   int? userId;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userCubit = BlocProvider.of<UserCubit>(context);
//     final user = userCubit.getCurrentUser();

//     setState(() {
//       username = user?.username;
//       userId = user?.id;
//     });
//   }

//   Future<void> deleteUserFromPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('user');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('Home Page'),
//             Text("Hello $username"),
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     PersistentNavBarNavigator.pushNewScreen(
//                       context,
//                       screen: const OrganizationBoardingPage(
//                         name: 'Dummy',
//                       ),
//                       withNavBar: false,
//                     );
//                   },
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Icon(Icons.create),
//                       SizedBox(width: 8),
//                       Text('Create organization'),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const JoinOrganizationPage(),
//                       ),
//                     );
//                   },
//                   child: const Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.add),
//                       SizedBox(width: 8),
//                       Text('Join organization'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   Text('Join organization'),
//                   if (userId == null) ...[
//                     const Text("User not logged in."),
//                   ] else ...[
//                     Expanded(
//                       child: FutureBuilder<List<Organization>>(
//                         future: BlocProvider.of<OrganizationCubit>(context)
//                             .getUserOrganizations(context, userId!),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           } else if (snapshot.hasError) {
//                             return Text("Error: ${snapshot.error}");
//                           } else if (snapshot.hasData) {
//                             final organizations = snapshot.data!;
//                             return ListView.builder(
//                               itemCount: organizations.length,
//                               itemBuilder: (context, index) {
//                                 final organization = organizations[index];
//                                 return InkWell(
//                                   onTap: () => Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           OrganizationDetailPage(
//                                               organizationId: organization.id!),
//                                     ),
//                                   ),
//                                   child: ListTile(
//                                     title: Text(organization.name!),
//                                   ),
//                                 );
//                               },
//                             );
//                           } else {
//                             return const Text("No organizations found.");
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: 300,
//               child: CustomElevatedButton(
//                 labelText: 'Logout',
//                 onPressed: () async {
//                   await deleteUserFromPreferences();
//                   BlocProvider.of<UserCubit>(context).logout();
//                   PersistentNavBarNavigator.pushNewScreen(
//                     context,
//                     screen: SignInPage(),
//                     withNavBar: false,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
      context.read<UserOrganizationsCubit>().getUserOrganizations(userId!);
    }
  }

  Future<void> deleteUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
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
                      screen: const OrganizationBoardingPage(
                        name: 'Dummy',
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
                  await deleteUserFromPreferences();
                  BlocProvider.of<UserCubit>(context).logout();
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
