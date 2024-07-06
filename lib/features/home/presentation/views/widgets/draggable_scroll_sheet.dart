
import 'package:estegatha/features/home/presentation/views/widgets/animated_organization_members_sliver_list_bloc_consumer.dart';
import 'package:estegatha/features/home/presentation/views/widgets/draggable_scroll_sheet_button.dart';
import 'package:estegatha/features/home/presentation/views/widgets/draggable_scroll_sheet_options.dart';
import 'package:estegatha/features/home/presentation/views/widgets/sliding_helper.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';

class DraggableScrollSheet extends StatelessWidget {
  const DraggableScrollSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const DraggableScrollSheetView();
  }
}

class DraggableScrollSheetView extends StatefulWidget {
  const DraggableScrollSheetView({super.key});

  @override
  State<DraggableScrollSheetView> createState() =>
      _DraggableScrollSheetViewState();
}

class _DraggableScrollSheetViewState extends State<DraggableScrollSheetView> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _keySection1 = GlobalKey();
  final GlobalKey _keySection2 = GlobalKey();
  final GlobalKey _keySection3 = GlobalKey();

  bool isExpanded = false;
  double opacity1 = 1.0;
  double opacity2 = 0.5;
  double opacity3 = 0.5;
  bool isSelected1 = true;
  bool isSelected2 = false;
  bool isSelected3 = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
    BlocProvider.of<OrganizationCubit>(context).getCurrentOrganizationMembers();
  }

  @override
  void dispose() {
    controller.removeListener(onChanged);
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  void toggleSelection(int index) {
    setState(() {
      isSelected1 = index == 0;
      isSelected2 = index == 1;
      isSelected3 = index == 2;
      opacity1 = index == 0 ? 1.0 : 0.5;
      opacity2 = index == 1 ? 1.0 : 0.5;
      opacity3 = index == 2 ? 1.0 : 0.5;
    });
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });


  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: sheet,
      maxChildSize: 1,
      minChildSize: .35,
      initialChildSize: .35,
      expand: true,
      snap: true,
      controller: controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: ConstantColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(ConstantSizes.defaultSpace),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Center(
                        child: SlidingHelper(),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: ConstantSizes.defaultSpace,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DraggableScrollSheetButton(
                            opacity: opacity1,
                            isSelected: isSelected1,
                            iconPath: ConstantImages.peopleIcon,
                            onPressed: () {
                              toggleSelection(0);
                              _scrollToSection(_keySection1);
                            },
                          ),
                          DraggableScrollSheetButton(
                            opacity: opacity2,
                            isSelected: isSelected2,
                            iconPath: ConstantImages.wayIcon,
                            onPressed: () {
                              toggleSelection(1);
                              _scrollToSection(_keySection2);
                            },
                          ),
                          DraggableScrollSheetButton(
                            opacity: opacity3,
                            isSelected: isSelected3,
                            iconPath: ConstantImages.buildingIcon,
                            onPressed: () {
                              toggleSelection(2);
                              _scrollToSection(_keySection3);
                            },
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: ConstantSizes.defaultSpace),
                          Text(
                            key: _keySection1,
                            "People",
                            style: const TextStyle(
                              color: ConstantColors.black,
                              fontSize: ConstantSizes.fontSizeLg,
                              fontWeight: ConstantSizes.fontWeightBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedOrganizationMembersSliverListBlocConsumer(
                      isExpanded: isExpanded,
                    ),
                    SliverToBoxAdapter(
                      child: IconButton(
                        onPressed: toggleExpanded,
                        icon: isExpanded
                            ? const Icon(Icons.arrow_upward)
                            : const Icon(Icons.arrow_downward),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: DraggableScrollSheetOptions(
                        keySection2: _keySection2,
                        keySection3: _keySection3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= .05) collapse();
  }

  void collapse() => animatedSheet(getSheet.snapSizes!.first);

  void anchor() => animatedSheet(getSheet.snapSizes!.last);

  void expand() => animatedSheet(getSheet.maxChildSize);

  void hide() => animatedSheet(getSheet.minChildSize);

  void animatedSheet(double size) {
    if (controller.isAttached) {
      size = size.clamp(0.0, 1.0); // Clamping the size value
      controller.animateTo(
        size,
        duration: const Duration(milliseconds: 50), // Changed to non-zero duration
        curve: Curves.easeInOut,
      );
    }
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}
