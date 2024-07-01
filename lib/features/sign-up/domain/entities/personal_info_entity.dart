import 'package:intl/intl.dart';

class PersonalInfoEntity {
  String? firstName;
  String? lastName;
  DateTime? birthDate;
  String? phoneNumber;

  PersonalInfoEntity({
    this.firstName,
    this.lastName,
    this.birthDate,
    this.phoneNumber,
  });
}
