import 'package:estegatha/features/home/presentation/views/widgets/animated_organization_header.dart';
import 'package:estegatha/features/home/presentation/views/widgets/animated_organizations_widget.dart';
import 'package:estegatha/features/home/presentation/views/widgets/dangerous_dialog.dart';
import 'package:estegatha/features/home/presentation/views/widgets/draggable_scroll_sheet.dart';
import 'package:estegatha/features/home/presentation/views/widgets/google_map.dart';
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                  GoogleMapView(),
                  if (state.organizationsVisible)
                    const AnimatedOrganizationsWidget(),
                  if (!state.organizationsVisible)
                    Positioned(
                        top: 40,
                        left: 20,
                        right: 20,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ConstantColors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                      ConstantImages.settingsAppbarIcon),
                                  onPressed: () {},
                                ),
                              ),
                              AnimatedOrganizationHeader(
                                isExpanded: false,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    color: ConstantColors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                          ConstantImages.messagesIcon)))
                            ])),
                  if (state.position != null && state.customMarker != null)
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      top: state.isAppBarVisible ? 0 : -100,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            context.read<HomeCubit>().hideToggleBar();
                            context.read<HomeCubit>().updateZoom(15);
                          },
                        ),
                        title: Text('Bishoy'),
                      ),
                    ),
                  Positioned(
                    bottom: height * .4,
                    left: width * .03,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: AnimatedOpacity(
                        opacity: _isButtonVisible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: IconButton(
                          onPressed: () {
                            //TODO: Implement Safety
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              color: ConstantColors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: ConstantSizes.defaultSpace,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  fit: BoxFit.cover,
                                  ConstantImages.safetySolidIcon,
                                ),
                                SizedBox(
                                  width: ConstantSizes.spaceBtwItems,
                                ),
                                Text(
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
                    child: Column(
                      children: [
                        SlideTransition(
                          position: _slideAnimation,
                          child: AnimatedOpacity(
                            opacity: _isButtonVisible ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 300),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ConstantColors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => DangerousDialog(),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  fit: BoxFit.cover,
                                  ConstantImages.warningIcon,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ConstantSizes.spaceBtwItems),
                        SlideTransition(
                          position: _slideAnimation,
                          child: AnimatedOpacity(
                            opacity: _isButtonVisible ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 300),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ConstantColors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  fit: BoxFit.cover,
                                  ConstantImages.gpsIcon,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            child: DraggableScrollSheet(),
                          ),
                          BottomNavBar(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    // Adjusted to not overlap with BottomNavBar and DraggableScrollSheet
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: BottomNavBarFAB(),
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
