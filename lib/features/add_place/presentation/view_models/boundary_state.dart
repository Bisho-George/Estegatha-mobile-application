part of 'boundary_cubit.dart';

@immutable
sealed class BoundaryState {}

final class BoundaryInitial extends BoundaryState {}

final class AddBoundaryLoading extends BoundaryState {}

final class AddBoundarySuccess extends BoundaryState {
  final List<OrganizationBoundaryEntity> boundaries;

  AddBoundarySuccess(this.boundaries);
}

final class AddBoundaryError extends BoundaryState {
  final String message;

  AddBoundaryError(this.message);
}

final class GetBoundariesLoading extends BoundaryState {}

final class GetBoundariesSuccess extends BoundaryState {
  final List<OrganizationBoundaryEntity> boundaries;

  GetBoundariesSuccess(this.boundaries);
}

final class GetBoundariesError extends BoundaryState {
  final String message;

  GetBoundariesError(this.message);
}