import 'package:estegatha/features/home/presentation/views/widgets/draggable_scroll_sheet_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../view_models/draggable_scroll_sheet/draggable_scroll_sheet_cubit.dart';
import '../../view_models/draggable_scroll_sheet/draggable_scroll_sheet_state.dart';
import 'draggable_scroll_sheet_list_item.dart';
import 'organization_option.dart';

class DraggableScrollSheet extends StatelessWidget {
  const DraggableScrollSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DraggableScrollSheetCubit(),
      child: DraggableScrollSheetView(),
    );
  }
}

class DraggableScrollSheetView extends StatefulWidget {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener(onChanged);
    _scrollController.dispose();
    controller.dispose();
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
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: ConstantColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
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
                      color: Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: ConstantSizes.defaultSpace,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<DraggableScrollSheetCubit,
                        DraggableScrollSheetState>(
                      builder: (context, state) {
                        return DraggableScrollSheetButton(
                            opacity: state.opacity1,
                            isSelected: state.isSelected1,
                            iconPath: ConstantImages.peopleIcon,
                            onPressed: () {
                              context
                                  .read<DraggableScrollSheetCubit>()
                                  .toggleSelection(1);
                              _scrollToSection(_keySection1);
                            });
                      },
                    ),
                    BlocBuilder<DraggableScrollSheetCubit,
                        DraggableScrollSheetState>(
                      builder: (context, state) {
                        return DraggableScrollSheetButton(
                            opacity: state.opacity2,
                            isSelected: state.isSelected2,
                            iconPath: ConstantImages.wayIcon,
                            onPressed: () {
                              context
                                  .read<DraggableScrollSheetCubit>()
                                  .toggleSelection(2);
                              _scrollToSection(_keySection2);
                            });
                      },
                    ),
                    BlocBuilder<DraggableScrollSheetCubit,
                        DraggableScrollSheetState>(
                      builder: (context, state) {
                        return DraggableScrollSheetButton(
                            opacity: state.opacity3,
                            isSelected: state.isSelected3,
                            iconPath: ConstantImages.buildingIcon,
                            onPressed: () {
                              context
                                  .read<DraggableScrollSheetCubit>()
                                  .toggleSelection(3);
                              _scrollToSection(_keySection3);
                            });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: ConstantSizes.defaultSpace),
                            Text(
                                key: _keySection1,
                                "People",
                                style: TextStyle(
                                  color: ConstantColors.black,
                                  fontSize: ConstantSizes.fontSizeLg,
                                  fontWeight: ConstantSizes.fontWeightBold,
                                )),
                          ],
                        ),
                      ),
                      BlocBuilder<DraggableScrollSheetCubit,
                          DraggableScrollSheetState>(
                        builder: (context, state) {
                          return SliverAnimatedList(
                            key: state.listKey,
                            initialItemCount: state.items.length,
                            itemBuilder: (context, index, animation) {
                              return SizeTransition(
                                sizeFactor: animation,
                                child: DraggableScrollSheetListItem(),
                              );
                            },
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: BlocBuilder<DraggableScrollSheetCubit,
                            DraggableScrollSheetState>(
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () => context
                                  .read<DraggableScrollSheetCubit>()
                                  .toggleExpanded(),
                              icon: state.isExpanded
                                  ? Icon(Icons.arrow_upward)
                                  : Icon(Icons.arrow_downward),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrganizationOption(
                                optionName: 'Add a member',
                                iconPath: ConstantImages.peopleIcon),
                            SizedBox(height: ConstantSizes.spaceBtwItems),
                            Text(
                                key: _keySection2,
                                "Track",
                                style: TextStyle(
                                  color: ConstantColors.black,
                                  fontSize: ConstantSizes.fontSizeMd,
                                  fontWeight: ConstantSizes.fontWeightBold,
                                )),
                            SizedBox(height: ConstantSizes.spaceBtwItems),
                            OrganizationOption(
                                optionName: 'Track member',
                                iconPath: ConstantImages.wayIcon),
                            SizedBox(height: ConstantSizes.spaceBtwItems),
                            Text(
                                key: _keySection3,
                                "Places",
                                style: TextStyle(
                                  color: ConstantColors.black,
                                  fontSize: ConstantSizes.fontSizeMd,
                                  fontWeight: ConstantSizes.fontWeightBold,
                                )),
                            SizedBox(height: ConstantSizes.spaceBtwItems),
                            OrganizationOption(
                                optionName: 'Manage places',
                                iconPath: ConstantImages.buildingIcon),
                          ],
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


  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= .05) collapse();
  }

  void collapse() => animatedSheet(getSheet.snapSizes!.first);

  void anchor() => animatedSheet(getSheet.snapSizes!.last);

  void expand() => animatedSheet(getSheet.maxChildSize);

  void hide() => animatedSheet(getSheet.minChildSize);

  void animatedSheet(double size) {
    controller.animateTo(size,
        duration: const Duration(microseconds: 50), curve: Curves.easeInOut);
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }
}
