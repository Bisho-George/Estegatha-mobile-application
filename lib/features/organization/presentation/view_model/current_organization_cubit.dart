import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentOrganizationState extends Equatable {
  final int? organizationId;

  const CurrentOrganizationState({this.organizationId});

  @override
  List<Object?> get props => [organizationId];
}

class CurrentOrganizationInitial extends CurrentOrganizationState {
  const CurrentOrganizationInitial() : super();
}

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
