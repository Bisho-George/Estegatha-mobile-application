import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(124.r);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        width: double.infinity.w,
        padding: EdgeInsets.symmetric(horizontal: ConstantSizes.md.w),
        height: 80.r,
        color: ConstantColors.primary,
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: ConstantColors.grey,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: ConstantColors.primary,
                    ),
                    onPressed: () {
                      // Handle settings button press
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 230.w,
                  height: 32.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: ConstantColors.grey,
                    borderRadius: BorderRadius.circular(30.0.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'Graduation project',
                      dropdownColor: ConstantColors.grey,
                      items: <String>[
                        'Graduation project',
                        'Organization 2',
                        'Organization 3'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: ConstantSizes.fontSizeMd.sp,
                                fontWeight: ConstantSizes.fontWeightSemiBold,
                                color: ConstantColors.primary),
                          ),
                        );
                      }).toList(),
                      onChanged: (_) {
                        // Handle organization selection
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: ConstantColors.grey,
                    borderRadius: BorderRadius.circular(30.0.r),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.inbox,
                      color: ConstantColors.primary,
                    ),
                    onPressed: () {
                      // Handle inbox button press
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: TabBar(
        unselectedLabelColor: ConstantColors.primary,
        labelStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: ConstantSizes.fontSizeSm.sp,
            fontWeight: ConstantSizes.fontWeightSemiBold,
            color: ConstantColors.primary),
        tabs: [
          Tab(
              icon: ImageIcon(
                const AssetImage(
                  ConstantImages.organizationTrackIcon,
                ),
                color: ConstantColors.iconPrimary,
                size: 20.r,
              ),
              text: 'Track location'),
          Tab(
              icon: ImageIcon(
                const AssetImage(ConstantImages.organizationHealthIcon),
                size: 20.r,
                color: ConstantColors.iconPrimary,
              ),
              text: 'Health status'),
          Tab(
              icon: ImageIcon(
                const AssetImage(ConstantImages.organizationPostIcon),
                size: 20.r,
                color: ConstantColors.iconPrimary,
              ),
              text: 'Posts'),
        ],
      ),
    );
  }
}
