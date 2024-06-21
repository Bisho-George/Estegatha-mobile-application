import 'package:estegatha/features/home/presentation/views/widgets/draggable_scroll_sheet_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../view_models/draggable_scroll_sheet/draggable_scroll_sheet_cubit.dart';
import '../../view_models/draggable_scroll_sheet/draggable_scroll_sheet_state.dart';
import 'draggable_scroll_sheet_list_item.dart';

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
  State<DraggableScrollSheetView> createState() => _DraggableScrollSheetViewState();
}

class _DraggableScrollSheetViewState extends State<DraggableScrollSheetView> {

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
    controller.dispose();
  }

  void onChanged () {
    final currentSize = controller.size;
    if (currentSize <= .05) collapse();
  }

  void collapse () => animatedSheet(getSheet.snapSizes!.first);
  void anchor () => animatedSheet(getSheet.snapSizes!.last);
  void expand () => animatedSheet(getSheet.maxChildSize);
  void hide () => animatedSheet(getSheet.minChildSize);
      void animatedSheet (double size) {
        controller.animateTo(size, duration: const Duration(microseconds: 50), curve: Curves.easeInOut);
      }
      DraggableScrollableSheet get getSheet => (sheet.currentWidget as DraggableScrollableSheet);

  final sheet = GlobalKey();
  final controller = DraggableScrollableController();
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
                          onPressed: () => context
                              .read<DraggableScrollSheetCubit>()
                              .toggleSelection(1),
                        );
                      },
                    ),
                    BlocBuilder<DraggableScrollSheetCubit,
                        DraggableScrollSheetState>(
                      builder: (context, state) {
                        return DraggableScrollSheetButton(
                          opacity: state.opacity2,
                          isSelected: state.isSelected2,
                          iconPath: ConstantImages.wayIcon,
                          onPressed: () => context
                              .read<DraggableScrollSheetCubit>()
                              .toggleSelection(2),
                        );
                      },
                    ),
                    BlocBuilder<DraggableScrollSheetCubit,
                        DraggableScrollSheetState>(
                      builder: (context, state) {
                        return DraggableScrollSheetButton(
                          opacity: state.opacity3,
                          isSelected: state.isSelected3,
                          iconPath: ConstantImages.buildingIcon,
                          onPressed: () => context
                              .read<DraggableScrollSheetCubit>()
                              .toggleSelection(3),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: ConstantSizes.defaultSpace),
                Text("People",
                    style: TextStyle(
                      color: ConstantColors.black,
                      fontSize: ConstantSizes.fontSizeLg,
                      fontWeight: ConstantSizes.fontWeightBold,
                    )),
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
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
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ConstantColors.primary.withOpacity(.1),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon:
                                      SvgPicture.asset(ConstantImages.peopleIcon,
                                      color: ConstantColors.primary,)),
                            ),
                            SizedBox(width: ConstantSizes.spaceBtwItems),
                            Text('Add a member',
                                style: TextStyle(
                                  color: ConstantColors.primary,
                                  fontSize: ConstantSizes.fontSizeMd,
                                  fontWeight: ConstantSizes.fontWeightBold,
                                ))
                          ],
                        ),
                      )
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
}
