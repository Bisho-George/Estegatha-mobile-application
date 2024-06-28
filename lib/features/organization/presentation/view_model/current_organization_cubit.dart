import 'package:bloc/bloc.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentOrganizationCubit extends Cubit<CurrentOrganizationState> {
  CurrentOrganizationCubit() : super(const CurrentOrganizationState());

  Future<void> loadCurrentOrganization() async {
    final prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getInt('currentOrganizationId');

    emit(CurrentOrganizationState(organizationId: organizationId));
  }

  Future<void> setCurrentOrganization(int organizationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentOrganizationId', organizationId);
    emit(CurrentOrganizationState(organizationId: organizationId));
  }

  void resetCurrentOrganizationState() {
    emit(const CurrentOrganizationInitial());
  }
}
