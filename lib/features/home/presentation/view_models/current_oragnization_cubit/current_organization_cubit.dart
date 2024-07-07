import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

import '../../../../organization/domain/models/organization.dart';

part 'current_organization_state.dart';

class CurrentOrganizationCubit extends Cubit<CurrentOrganizationState> {
  CurrentOrganizationCubit() : super(CurrentOrganizationInitial());
  Organization? currentOrganization;

  Future<void> checkCurrentOrganization() async {
    final box = GetStorage();
    final String? organizationJson = box.read('currentOrganization');

    if (organizationJson != null) {
      final Map<String, dynamic> organizationMap = jsonDecode(organizationJson);
      currentOrganization = Organization.fromJson(organizationMap);
      emit(CurrentOrganizationLoaded(Organization.fromJson(organizationMap)));
    } else {
      emit(CurrentOrganizationInitial());
    }
  }

  Future<Organization?> loadCurrentOrganization() async {
    final box = GetStorage();
    final String? organizationJson = box.read('currentOrganization');

    if (organizationJson != null) {
      final Map<String, dynamic> organizationMap = jsonDecode(organizationJson);
      currentOrganization = Organization.fromJson(organizationMap);
      return Organization.fromJson(organizationMap);
    }
    return null;
  }

  Future<void> setCurrentOrganization(Organization organization) async {
    final box = GetStorage();
    final String organizationJson = jsonEncode(organization.toJson());
    await box.write('currentOrganization', organizationJson);
    emit(CurrentOrganizationLoaded(organization));
    currentOrganization = organization;
  }

  void resetCurrentOrganizationState() {
    final box = GetStorage();
    box.remove('currentOrganization');
    emit(CurrentOrganizationInitial());
    currentOrganization = null;
  }
}
