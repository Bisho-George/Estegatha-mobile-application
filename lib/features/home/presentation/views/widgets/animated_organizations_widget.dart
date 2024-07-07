import 'package:estegatha/features/organization/presentation/view_model/user_organizations_cubit.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../view_models/home_state.dart';
import '../../view_models/home_view_model.dart';
import 'animated_organization_header.dart';
import 'organization_list_view.dart';
import 'organizations_bloc_builder.dart';

class AnimatedOrganizationsWidget extends StatefulWidget {
  const AnimatedOrganizationsWidget({super.key});

  @override
  State<AnimatedOrganizationsWidget> createState() =>
      _AnimatedOrganizationsWidgetState();
}

class _AnimatedOrganizationsWidgetState
    extends State<AnimatedOrganizationsWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<Offset> _animation;
  late final AnimationController _animationController;

  TickerFuture _reverseAnimation() => _animationController.reverse();

  void _startAnimation() {
    _animationController.forward();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, -1), // Start slightly off the top
      end: const Offset(0, 0), // Move to the normal position
    ).animate(_animationController);
    _startAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  Future<bool> _onWillPop() async {
    await _animationController.reverse();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SlideTransition(
          position: _animation,
          child: Container(
              height: MediaQuery.of(context).size.height / 3.2,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ConstantSizes.defaultSpace),
                  bottomRight: Radius.circular(ConstantSizes.defaultSpace),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: ConstantSizes.defaultSpace),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: ConstantSizes.defaultSpace),
                    child: Row(
                      children: [
                        AnimatedOrganizationHeader(
                          isExpanded: state.organizationsVisible,
                        ),
                        const SizedBox(width: ConstantSizes.defaultSpace + 10),
                        IconButton(
                          icon: SvgPicture.asset(ConstantImages.addPersonIcon),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwItems,
                  ),
                  const OrganizationsBlocBuilder(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: responsiveWidth(ConstantSizes.spaceBtwItems)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                              onPressed: () {}, labelText: "Join Organization", textSize: 16.0,),
                        ),
                         SizedBox(width: responsiveWidth(ConstantSizes.spaceBtwItems)),
                        Expanded(
                          child: CustomElevatedButton(
                              onPressed: () {}, labelText: "Create Organization", textSize: 16.0),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
