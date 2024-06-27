import 'package:estegatha/constants.dart';

class ContactModel{
  final String name;
  final String phoneNumber;

  ContactModel({required this.name, required this.phoneNumber});
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json[contactNameKey],
      phoneNumber: json[contactPhoneKey]
    );
  }
}