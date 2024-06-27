part of 'sos_index_cubit.dart';

@immutable
sealed class SosIndexState {}

final class SosIndexInitial extends SosIndexState {}

final class SosIndexChange extends SosIndexState {
  final int index;
  SosIndexChange(this.index);
}
