import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';

class DraggableScrollSheet extends StatefulWidget {
  const DraggableScrollSheet({super.key});

  @override
  _DraggableScrollSheetState createState() => _DraggableScrollSheetState();
}

class _DraggableScrollSheetState extends State<DraggableScrollSheet> {
  static const fontSize = ConstantSizes.fontSizeSm * .7;

  double _opacity1 = 1.0;
  double _opacity2 = 0.5;
  double _opacity3 = 0.5;

  bool _isSelected1 = true;
  bool _isSelected2 = false;
  bool _isSelected3 = false;

  void _toggleSelection(int index) {
    setState(() {
      _isSelected1 = index == 1;
      _isSelected2 = index == 2;
      _isSelected3 = index == 3;

      _opacity1 = _isSelected1 ? 1.0 : 0.5;
      _opacity2 = _isSelected2 ? 1.0 : 0.5;
      _opacity3 = _isSelected3 ? 1.0 : 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: 400,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(ConstantSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 30,
                    height: 7,
                    decoration: BoxDecoration(
                      color: ConstantColors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: ConstantSizes.defaultSpace),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildAnimatedIconButton(
                        opacity: _opacity1,
                        isSelected: _isSelected1,
                        selectedColor: ConstantColors.primary.withOpacity(.89),
                        unselectedColor: ConstantColors.primaryBackground,
                        iconPath: ConstantImages.peopleIcon,
                        onPressed: () => _toggleSelection(1),
                      ),
                      _buildAnimatedIconButton(
                        opacity: _opacity2,
                        isSelected: _isSelected2,
                        selectedColor: ConstantColors.primary.withOpacity(.89),
                        unselectedColor: ConstantColors.primaryBackground,
                        iconPath: ConstantImages.wayIcon,
                        onPressed: () => _toggleSelection(2),
                      ),
                      _buildAnimatedIconButton(
                        opacity: _opacity3,
                        isSelected: _isSelected3,
                        selectedColor: ConstantColors.primary.withOpacity(.89),
                        unselectedColor: ConstantColors.primaryBackground,
                        iconPath: ConstantImages.buildingIcon,
                        onPressed: () => _toggleSelection(3),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ConstantSizes.spaceBtwItems),
                Text("People",
                    style: TextStyle(
                      color: ConstantColors.primary,
                      fontSize: ConstantSizes.fontSizeLg,
                      fontWeight: ConstantSizes.fontWeightBold,
                    )),
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) => listItem(),
                          childCount: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget listItem() {
    return Row(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(ConstantImages.user),
            ),
            title: Text("Bishoy"),
            subtitle: Text("Developer"),
          ),
        ]
    );
  }

  Widget _buildAnimatedIconButton({
    required double opacity,
    required bool isSelected,
    required Color selectedColor,
    required Color unselectedColor,
    required String iconPath,
    required VoidCallback onPressed,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : unselectedColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Opacity(
        opacity: opacity,
        child: IconButton(
          icon: SvgPicture.asset(iconPath, height: 18),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
