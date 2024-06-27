import 'package:estegatha/features/organization/presentation/view/main/navigation_cubit/navigation_cubit.dart';
import 'package:estegatha/home_page.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});

  final List<Widget> _pages = [
    HomePage(),
    const SettingPage(),
  ];

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: ConstantColors.secondary,
                foregroundColor: ConstantColors.primary,
                elevation: 10,
                mini: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.people_outline,
                ),
              ),
              bottomNavigationBar: NavigationBar(
                height: 65,
                elevation: 10,
                selectedIndex: state,
                onDestinationSelected: (index) {
                  BlocProvider.of<NavigationCubit>(context).selectIndex(index);
                },
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(
                      icon: Icon(Icons.settings), label: 'Settings'),
                  // Add more destinations here...
                ],
              ),
              body: Stack(
                children: _pages.asMap().entries.map<Widget>(
                  (entry) {
                    int i = entry.key;
                    Widget page = entry.value;
                    return Offstage(
                      offstage: state != i,
                      child: Navigator(
                        key: _navigatorKeys[i],
                        onGenerateRoute: (settings) {
                          return MaterialPageRoute(
                            builder: (context) => page,
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

// craete Setting page

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
