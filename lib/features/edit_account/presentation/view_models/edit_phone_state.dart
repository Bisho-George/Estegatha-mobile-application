import '../../../organization/domain/models/member.dart';

class EditPhoneState{}
class EditPhoneInitial extends EditPhoneState{}
class EditPhoneLoading extends EditPhoneState{}
class EditPhoneSuccess extends EditPhoneState{
  String message;
  Member newMember;
  EditPhoneSuccess(this.newMember, this.message);
}
class EditPhoneFailure extends EditPhoneState{
  String message;
  EditPhoneFailure(this.message);
}