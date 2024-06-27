import 'package:estegatha/features/edit_account/presentation/pages/edit_account_menu.dart';
import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/home_page.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainNavMenu extends StatelessWidget {
  const MainNavMenu({super.key});
  static String routeName = "/main_nav_menu";
  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        HomePage(),
        const Center(
          child: Text("Safety screen"),
        ),
        const OrganizationDetailPage(
          // pass organizationId to the screen
          organizationId: 1,
        ),
        const Center(
          child: Text("Catalog screen"),
        ),
        const Center(
          child: Text("Setting screen"),
        ),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        // Home
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: ConstantColors.secondary,
          inactiveColorPrimary: Colors.grey,
        ),
        // Safety
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.health_and_safety),
          title: ("Safety"),
          activeColorPrimary: ConstantColors.secondary,
          inactiveColorPrimary: Colors.grey,
        ),
        // Organization
        PersistentBottomNavBarItem(
          iconSize: 28.r,
          icon: const Icon(
            Icons.people,
            color: Colors.white,
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
          activeColorPrimary: ConstantColors.secondary,
          inactiveColorPrimary: ConstantColors.darkGrey,
        ),
        // Settings
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: ("Setting"),
          activeColorPrimary: ConstantColors.secondary,
          inactiveColorPrimary: ConstantColors.darkGrey,
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);
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

      // popAllScreensOnTapAnyTabs: true,
    );
  }
}
