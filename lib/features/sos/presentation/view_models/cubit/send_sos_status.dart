import '../../../../organization/domain/models/member.dart';

class SendSosStatus{}
class SendSosInitial extends SendSosStatus{}
class SendSosLoading extends SendSosStatus{}
class SendSosSuccess extends SendSosStatus{}
class SendSosFailure extends SendSosStatus{
  final String ?message;
  SendSosFailure({this.message});
}
class MemberReceivedFailure extends SendSosStatus{
  final String ?message;
  MemberReceivedFailure({this.message});
}
class MembersReceivedStatus extends SendSosStatus{
  final List<Member> members;
  MembersReceivedStatus({required this.members});
}