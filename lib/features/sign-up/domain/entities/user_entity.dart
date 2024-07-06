import 'package:estegatha/features/sign-up/domain/entities/personal_info_entity.dart';

class UserEntity {
  PersonalInfoEntity? personalInfo;
  String? email;
  String? password;
  String? address;
  String? lat;
  String? lang;

  // Constructor
  UserEntity(
      {required this.personalInfo,
      required this.email,
      required this.password,
      required this.address,
      required this.lat,
      required this.lang});

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
