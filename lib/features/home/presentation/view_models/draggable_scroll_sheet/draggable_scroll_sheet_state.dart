import 'package:flutter/material.dart';

class DraggableScrollSheetState {
  final bool isExpanded;
  final double opacity1;
  final double opacity2;
  final double opacity3;
  final bool isSelected1;
  final bool isSelected2;
  final bool isSelected3;
  final List<int> items;
  final GlobalKey<SliverAnimatedListState> listKey;

  DraggableScrollSheetState({
    required this.isExpanded,
    required this.opacity1,
    required this.opacity2,
    required this.opacity3,
    required this.isSelected1,
    required this.isSelected2,
    required this.isSelected3,
    required this.items,
    required this.listKey,
  });

  DraggableScrollSheetState copyWith({
    bool? isExpanded,
    double? opacity1,
    double? opacity2,
    double? opacity3,
    bool? isSelected1,
    bool? isSelected2,
    bool? isSelected3,
    List<int>? items,
    GlobalKey<SliverAnimatedListState>? listKey,
  }) {
    return DraggableScrollSheetState(
      isExpanded: isExpanded ?? this.isExpanded,
      opacity1: opacity1 ?? this.opacity1,
      opacity2: opacity2 ?? this.opacity2,
      opacity3: opacity3 ?? this.opacity3,
      isSelected1: isSelected1 ?? this.isSelected1,
      isSelected2: isSelected2 ?? this.isSelected2,
      isSelected3: isSelected3 ?? this.isSelected3,
      items: items ?? this.items,
      listKey: listKey ?? this.listKey,
    );
  }
}
