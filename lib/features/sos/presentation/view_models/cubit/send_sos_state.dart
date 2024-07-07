import '../../../../organization/domain/models/member.dart';
import '../../../../organization/domain/models/organizationMember.dart';

class SendSosState{}
class SendSosInitial extends SendSosState{}
class SendSosLoading extends SendSosState{}
class SendSosSuccess extends SendSosState{}
class SendSosFailure extends SendSosState{
  final String ?message;
  SendSosFailure({this.message});
}
class MemberReceivedFailure extends SendSosState{
  final String ?message;
  MemberReceivedFailure({this.message});
}
class MembersReceivedStatus extends SendSosState{
  final List<OrganizationMember> members;
  MembersReceivedStatus({required this.members});
}