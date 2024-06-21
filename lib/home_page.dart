import 'package:estegatha/features/organization/presentation/view/boarding_page.dart';
import 'package:estegatha/features/organization/presentation/view/join/final_join_organization_page.dart';
import 'package:estegatha/features/organization/presentation/view/join/join_organization_page.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home_page';

  @override
  Widget build(BuildContext context) {
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
                      screen: OrganizationBoardingPage(
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
            Container(
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
