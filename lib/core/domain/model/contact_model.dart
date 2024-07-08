import 'package:estegatha/constants.dart';

class ContactModel{
  String name;
  String phoneNumber;
  int id;
  ContactModel({required this.name, required this.phoneNumber, required this.id});
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json[contactNameKey],
      phoneNumber: json[contactPhoneKey],
      id : json['id']
    );
  }
}