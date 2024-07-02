import 'package:estegatha/features/home/presentation/views/widgets/animated_organizations_widget.dart';
import 'package:estegatha/features/home/presentation/views/widgets/custom_fab.dart';
import 'package:estegatha/features/home/presentation/views/widgets/custom_home_appbar.dart';
import 'package:estegatha/features/home/presentation/views/widgets/custom_person_appbar.dart';
import 'package:estegatha/features/home/presentation/views/widgets/draggable_scroll_sheet.dart';
import 'package:estegatha/features/home/presentation/views/widgets/google_map.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/common/widgets/bottom_navbar.dart';
import '../../../../utils/common/widgets/bottom_navbar_fab.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/image_strings.dart';
import '../view_models/home_state.dart';
import '../view_models/home_view_model.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isButtonVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _onScroll(double position) {
    if (position > 0.36 && _isButtonVisible) {
      _animationController.forward();
      setState(() {
        _isButtonVisible = false;
      });
    } else if (position <= 0.36 && !_isButtonVisible) {
      _animationController.reverse();
      setState(() {
        _isButtonVisible = true;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).height;
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) async {
            if (state.position != null) {
              BlocProvider.of<HomeCubit>(context).animateCamera();
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: [
                  const GoogleMapView(),
                  if (state.organizationsVisible)
                    const AnimatedOrganizationsWidget(),
                  if (!state.organizationsVisible)
                    Positioned(
                        top: responsiveHeight(20),
                        left: responsiveWidth(20),
                        right: responsiveWidth(20),
                        child: const CustomHomeAppBar()),
                  if (state.position != null && state.customMarker != null)
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      top: state.isAppBarVisible ? 0 : responsiveHeight(-100),
                      left: 0,
                      right: 0,
                      child: const CustomPersonAppBar(),
                    ),
                  Positioned(
                    bottom: height * .4,
                    left: width * .03,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: AnimatedOpacity(
                        opacity: _isButtonVisible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: IconButton(
                          onPressed: () {
                            //TODO: Implement Safety
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              color: ConstantColors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: ConstantSizes.defaultSpace,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  fit: BoxFit.cover,
                                  ConstantImages.safetySolidIcon,
                                ),
                                const SizedBox(
                                  width: ConstantSizes.spaceBtwItems,
                                ),
                                const Text(
                                  "Safety",
                                  style: TextStyle(
                                    color: ConstantColors.primary,
                                    fontSize: ConstantSizes.fontSizeMd,
                                    fontWeight:
                                        ConstantSizes.fontWeightSemiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: height * .4,
                    right: width * .03,
                    child: CustomFAB(slideAnimation: _slideAnimation, isButtonVisible: _isButtonVisible),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child:
                        NotificationListener<DraggableScrollableNotification>(
                      onNotification: (notification) {
                        _onScroll(notification.extent);
                        return true;
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .88,
                            child: const DraggableScrollSheet(),
                          ),
                          const BottomNavBar(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    // Adjusted to not overlap with BottomNavBar and DraggableScrollSheet
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: const BottomNavBarFAB(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
