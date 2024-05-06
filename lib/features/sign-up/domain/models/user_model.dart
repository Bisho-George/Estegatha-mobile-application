import 'package:estegatha/features/sign-up/domain/models/personal_info_model.dart';

class UserModel {
  PersonalInfoModel? personalInfo;
  String? email;
  String? password;
  String? address;

  // Constructor
  UserModel({
    required this.personalInfo,
    required this.email,
    required this.password,
    required this.address,
  });

  // // Method to create a UserModel from JSON
  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     firstName: json['firstName'],
  //     lastName: json['lastName'],
  //     // Parse 'birthday' string to DateTime if it exists
  //     birthday: json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
  //     phoneNumber: json['phoneNumber'],
  //     email: json['email'],
  //     password: json['password'],
  //     address: json['address'],
  //   );
  // }
  //
  // // Method to convert a UserModel to JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'birthday': birthday?.toIso8601String(), // Convert DateTime to string
  //     'phoneNumber': phoneNumber,
  //     'email': email,
  //     'password': password,
  //     'address': address,
  //   };
  // }
}
