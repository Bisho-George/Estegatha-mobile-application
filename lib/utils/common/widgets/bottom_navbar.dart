import 'package:estegatha/features/home/presentation/views/home_view.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant/image_strings.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<String> _pages = [
    HomeView.routeName,
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      if (index != 2) {
        Navigator.pushNamed(context, _pages[index]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double fontSize = ConstantSizes.fontSizeSm * .8;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: ConstantColors.primary,
      // Set the color for selected items
      unselectedItemColor: ConstantColors.secondaryBackground,
      // Set the color for unselected items
      selectedLabelStyle: TextStyle(
        color: ConstantColors.primary,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: ConstantColors.secondaryBackground,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      ),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ConstantImages.homeIcon,
            width: fontSize * 2.5, // Adjust the size dynamically
            height: fontSize * 2.5, // Adjust the size dynamically
            color: _selectedIndex == 0
                ? ConstantColors.primary
                : ConstantColors
                    .secondaryBackground, // Change color based on selection
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ConstantImages.safetyIcon,
            width: fontSize * 2.5, // Adjust the size dynamically
            height: fontSize * 2.5, // Adjust the size dynamically
            color: _selectedIndex == 1
                ? ConstantColors.primary
                : ConstantColors
                    .secondaryBackground, // Change color based on selection
          ),
          label: 'Safety',
        ),
        BottomNavigationBarItem(
          icon: Container(),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ConstantImages.catalogIcon,
            width: fontSize * 2.5, // Adjust the size dynamically
            height: fontSize * 2.5, // Adjust the size dynamically
            color: _selectedIndex == 3
                ? ConstantColors.primary
                : ConstantColors
                    .secondaryBackground, // Change color based on selection
          ),
          label: 'Catalog',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ConstantImages.settingsIcon,
            width: fontSize * 2.5, // Adjust the size dynamically
            height: fontSize * 2.5, // Adjust the size dynamically
            color: _selectedIndex == 4
                ? ConstantColors.primary
                : ConstantColors
                    .secondaryBackground, // Change color based on selection
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
