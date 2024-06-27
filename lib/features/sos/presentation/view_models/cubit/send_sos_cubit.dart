import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/sos/data/api/organizations_api.dart';
import 'package:estegatha/features/sos/data/api/sos_api.dart';
import 'package:estegatha/features/sos/domain/repositories/organizations_repo.dart';
import 'package:estegatha/features/sos/domain/repositories/sos_repo.dart';
import 'package:estegatha/features/sos/presentation/pages/send_sos.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/send_sos_status.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../organization/domain/models/organizationMember.dart';
class SendSosCubit extends Cubit<SendSosStatus>{
  SendSosCubit():super(SendSosInitial());
  Future<void> getMembers() async {
    emit(SendSosLoading());
    List<OrganizationMember> members = [];
    OrganizationsRepo repo = OrganizationsApi();
    try{
      Member ?user = await HelperFunctions.getUser();
      List<Organization> organizations = await repo.fetchOrganizations().timeout(Duration(seconds: durationTimeout));
      for (var organization in organizations) {
        if(organization.organizationSize != null && organization.organizationSize! > 0){
          List<OrganizationMember> organizationMembers =
          await repo.fetchOrganizationMembers(organization.id!).timeout(Duration(seconds: durationTimeout));
          organizationMembers.removeWhere((element) => element.userId == user!.id);
          members.addAll(organizationMembers);
        }
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
      int numOfSuccess = await repo.sendSos().timeout(Duration(seconds: durationTimeout));
      if(numOfSuccess != 0){
        emit(SendSosSuccess());
      }
      else{
        emit(SendSosFailure(message: 'Failed to send sos request'));
      }
    }catch(e){
      emit(SendSosFailure(message: 'Failed to send sos request'));
    }
  }
}