import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/sos/data/api/organizations_api.dart';
import 'package:estegatha/features/sos/data/api/sos_api.dart';
import 'package:estegatha/features/sos/domain/repositories/organizations_repo.dart';
import 'package:estegatha/features/sos/domain/repositories/sos_repo.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/send_sos_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SendSosCubit extends Cubit<SendSosStatus>{
  SendSosCubit():super(SendSosInitial());
  Future<void> getMembers() async {
    emit(SendSosLoading());
    List<Member> members = [];
    OrganizationsRepo repo = OrganizationsApi();
    try{
      List<Organization> organizations = await repo.fetchOrganizations();
      for (var organization in organizations) {
        List<Member> organizationMembers =
            await repo.fetchOrganizationMembers(organization.id);
        members.addAll(organizationMembers);
      }
      emit(MembersReceivedStatus(members: members));
    }catch(e){
      emit(MemberReceivedFailure(message: 'Can\'t get organizations members'));
    }
  }
  Future<void> sendSos() async {
    emit(SendSosLoading());
    SosRepo repo = SosApi();
    try{
      int statusCode = await repo.sendSos();
      if(statusCode == 200 || statusCode == 201){
        emit(SendSosSuccess());
      }
    }catch(e){
      emit(SendSosFailure(message: 'Failed to send sos request'));
    }
  }
}