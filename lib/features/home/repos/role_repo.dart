import '../api/role_api.dart';

class RoleRepo {
  final RoleApi _roleApi;

  RoleRepo(this._roleApi);

  Future<String> getRoles(int orgId) async {
    final response = await _roleApi.getRole(orgId);
    return response;
  }
}