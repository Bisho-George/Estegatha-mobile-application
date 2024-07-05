import 'package:estegatha/features/catalog/persentation/view/catalog_screen.dart';
import 'package:estegatha/features/home/presentation/views/home_view.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_state.dart';
import 'package:estegatha/features/safety/presentation/view/safety_screen.dart';
import 'package:estegatha/features/settings/presentation/view/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_page.dart';
import 'features/organization/presentation/view/main/organization_detail_page.dart';
import 'utils/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainNavMenu extends StatefulWidget {
  const MainNavMenu({super.key});
  static String routeName = "/main_nav_menu";

  @override
  _MainNavMenuState createState() => _MainNavMenuState();
}

class _MainNavMenuState extends State<MainNavMenu> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<Widget> buildScreens() {
    return [
      HomeView(),
      const SafetyScreen(),
      OrganizationDetailPage(
        organizationId: 1, // TODO: change this to organizationId
      ),
      const CatalogScreen(),
      const SettingsScreen()
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      // Home
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: ConstantColors.primary,
        inactiveColorPrimary: ConstantColors.secondary,
      ),
      // Safety
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.health_and_safety),
        title: ("Safety"),
        activeColorPrimary: ConstantColors.primary,
        inactiveColorPrimary: ConstantColors.secondary,
      ),
      // Organization
      PersistentBottomNavBarItem(
        iconSize: 28.r,
        icon: const Icon(
          Icons.people,
          color: ConstantColors.primary,
        ),
        inactiveIcon: const Icon(
          Icons.people_outline,
          color: Colors.white,
        ),
        activeColorPrimary: ConstantColors.secondary,
        inactiveColorPrimary: ConstantColors.darkGrey,
      ),
      // Catalog
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.help_center_outlined),
        title: ("Catalog"),
        activeColorPrimary: ConstantColors.primary,
        inactiveColorPrimary: ConstantColors.secondary,
      ),
      // Settings
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Setting"),
        activeColorPrimary: ConstantColors.primary,
        inactiveColorPrimary: ConstantColors.secondary,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentOrganizationCubit, CurrentOrganizationState>(
      builder: (context, state) {
        return PersistentTabView(
          navBarHeight: 60.0.h,
          context,
          screens: buildScreens(),
          items: navBarsItems(),
          controller: controller,
          confineInSafeArea: true,
          backgroundColor: ConstantColors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: const NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            colorBehindNavBar: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ConstantColors.secondary,
                spreadRadius: 0.4,
                blurRadius: 1,
                offset: Offset(0, 1),
              )
            ],
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 150),
            curve: Curves.easeInOut,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 150),
          ),
          navBarStyle: NavBarStyle.style15,
        );
      },
    );
  }
}
