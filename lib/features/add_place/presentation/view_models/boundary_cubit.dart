import 'package:bloc/bloc.dart';
import 'package:estegatha/features/add_place/domain/use_cases/add_boundary_use_case.dart';
import 'package:meta/meta.dart';

import '../../data/models/organization_boundary_response.dart';
import '../../domain/entities/organization_boundary_entity.dart';
import '../../domain/use_cases/get_boundaries_use_case.dart';

part 'boundary_state.dart';

class BoundaryCubit extends Cubit<BoundaryState> {
  final AddBoundaryUseCase addBoundaryUseCase;
  final GetBoundariesUseCase getBoundariesUseCase;
  double lat = 0;
  double lang = 0;
  double radius = 0;
  String name = "";

  BoundaryCubit(this.addBoundaryUseCase, this.getBoundariesUseCase) : super(BoundaryInitial());

  void updateLatLng (double lat, double lang) {
    this.lat = lat;
    this.lang = lang;
  }

  void updateRadius (double radius) {
    this.radius = radius;
  }

  void updateName (String name) {
    this.name = name;
  }

  Future<OrganizationBoundaryResponse> addBoundary(
      num organizationId, OrganizationBoundaryEntity boundary) async {
    emit(AddBoundaryLoading());
    final result = await addBoundaryUseCase(organizationId, boundary);
    return result.fold(
      (failure) {
        emit(AddBoundaryError(failure.message));
        return OrganizationBoundaryResponse(success: false, message: failure.message);
      },
      (response) {
        emit(AddBoundarySuccess(response.organizationBoundaries!));
        return response;
      },
    );
  }

}
