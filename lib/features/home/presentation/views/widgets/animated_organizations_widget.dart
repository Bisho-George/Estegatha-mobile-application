import 'package:estegatha/features/home/presentation/views/widgets/organization_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../view_models/home_state.dart';
import '../../view_models/home_view_model.dart';
import 'animated_organization_header.dart';

class AnimatedOrganizationsWidget extends StatefulWidget {
  const AnimatedOrganizationsWidget({
    super.key,

  });

  @override
  State<AnimatedOrganizationsWidget> createState() =>
      _AnimatedOrganizationsWidgetState();
}

class _AnimatedOrganizationsWidgetState
    extends State<AnimatedOrganizationsWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<Offset> _animation;
  late final AnimationController _animationController;

  TickerFuture  _reverseAnimation () => _animationController.reverse();
  void _startAnimation()  {
    // await Future.delayed(Duration(seconds: 3));
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
      begin: Offset(0, -1),  // Start slightly off the top
      end: Offset(0, 0),  // Move to the normal position
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SlideTransition(
          position: _animation,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.sizeOf(context).height / 4,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(children: [
                Positioned(
                    top: 40,
                    left: MediaQuery.sizeOf(context).width / 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            AnimatedOrganizationHeader(isExpanded: state.organizationsVisible),
                            const SizedBox(width: ConstantSizes.defaultSpace),
                            SvgPicture.asset(ConstantImages.addPersonIcon),
                          ],
                        ),
                        const OrganizationWidget(),
                      ],
                    ))
              ])),
        );
      },
    );
  }
}
