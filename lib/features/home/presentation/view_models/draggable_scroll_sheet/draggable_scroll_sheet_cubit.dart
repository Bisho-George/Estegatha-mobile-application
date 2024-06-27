import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'draggable_scroll_sheet_state.dart';

class DraggableScrollSheetCubit extends Cubit<DraggableScrollSheetState> {
  DraggableScrollSheetCubit()
      : super(DraggableScrollSheetState(
    isExpanded: false,
    opacity1: 1.0,
    opacity2: 0.5,
    opacity3: 0.5,
    isSelected1: true,
    isSelected2: false,
    isSelected3: false,
    items: [0, 1, 2],
    listKey: GlobalKey<SliverAnimatedListState>(),
  ));

  void toggleSelection(int index) {
    emit(state.copyWith(
      isSelected1: index == 1,
      isSelected2: index == 2,
      isSelected3: index == 3,
      opacity1: index == 1 ? 1.0 : 0.5,
      opacity2: index == 2 ? 1.0 : 0.5,
      opacity3: index == 3 ? 1.0 : 0.5,
    ));
  }

  void toggleExpanded() {
    final isExpanded = state.isExpanded;
    final listKey = state.listKey;

    if (isExpanded) {
      for (int i = 3; i < 10; i++) {
        listKey.currentState?.removeItem(
          3,
              (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: Container(), // Adjust to match your DraggableScrollSheetListItems widget
          ),
        );
      }
    } else {
      for (int i = 3; i < 10; i++) {
        listKey.currentState?.insertItem(i);
      }
    }

    emit(state.copyWith(isExpanded: !isExpanded));
  }
}
