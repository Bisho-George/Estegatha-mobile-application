import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../view_models/home_view_model.dart';


class AnimatedOrganizationHeader extends StatefulWidget {
   bool isExpanded;
   AnimatedOrganizationHeader({super.key,
    required this.isExpanded,
   });

  @override
  State<AnimatedOrganizationHeader> createState() =>
      _AnimatedOrganizationHeaderState();
}

class _AnimatedOrganizationHeaderState extends State<AnimatedOrganizationHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.5),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleOnPressed() {
    setState(() {
      if (widget.isExpanded) {
        BlocProvider.of<HomeCubit>(context).hideOrganizations();
        _controller.reverse();
      } else {
        BlocProvider.of<HomeCubit>(context).showOrganizations();
        _controller.forward();
      }
      widget.isExpanded = !widget.isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ConstantColors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: ConstantColors.grey,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: IconButton(
            icon: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstantSizes.spaceBtwItems),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "graduation project",
                    style: TextStyle(
                      color: ConstantColors.primary,
                      fontSize: ConstantSizes.fontSizeMd,
                      fontWeight: ConstantSizes.fontWeightSemiBold,
                    ),
                  ),
                  SizedBox(
                    width: ConstantSizes.defaultSpace,
                  ),
                  AnimatedRotation(
                    turns: widget.isExpanded ? 0.5 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child:
                    SvgPicture.asset(ConstantImages.organizationArrowIcon),
                  ),
                ],
              ),
            ),
            onPressed: () {
              _handleOnPressed();
            },
          ),
        ),
      ],
    );
  }
}
