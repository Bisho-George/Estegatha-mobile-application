import 'package:dio/dio.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/add_place/data/models/organization_boundary_response.dart';
import 'package:estegatha/features/add_place/domain/entities/organization_boundary_entity.dart';
import 'package:estegatha/utils/services/api_service.dart';

import '../models/organization_boundary_model.dart';

class BoundaryRemoteDataSource {
  final ApiService _apiService;

  BoundaryRemoteDataSource(this._apiService);

  Future<OrganizationBoundaryResponse> addPlace(
      num id, OrganizationBoundaryEntity organizationEntity) async {
    Dio dio = await DioAuth.getDio();

    var result =
        await _apiService.post(endpoint: 'organizations/boundaries/$id', data: {
      'name': organizationEntity.name,
      'lat': organizationEntity.lat,
      'lang': organizationEntity.lang,
      'radius': organizationEntity.radius,
    });
    List<OrganizationBoundaryEntity> boundaries =
        getOrganizationBoundaries(result);
    return OrganizationBoundaryResponse(
        success: result.data['success'] ?? true,
        message: result.data['message'] ?? '',
        organizationBoundaries: boundaries);
  }

  Future<List<OrganizationBoundaryEntity>> getBoundaries(num id) async {
    var result =
        await _apiService.get(endpoint: 'organizations/boundaries/$id');
    List<OrganizationBoundaryEntity> boundaries =
        getOrganizationBoundaries(result);
    return boundaries;
  }

  List<OrganizationBoundaryEntity> getOrganizationBoundaries(
      Map<String, dynamic> data) {
    List<OrganizationBoundaryEntity> boundaries = [];
    for (var boundary in data as List) {
      boundaries.add(OrganizationBoundaryModel.fromJson(boundary));
    }
    return boundaries;
  }
}
