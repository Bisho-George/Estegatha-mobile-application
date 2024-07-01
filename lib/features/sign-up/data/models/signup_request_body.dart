import 'package:estegatha/features/sign-up/domain/entities/personal_info_entity.dart';
import 'package:estegatha/features/sign-up/domain/entities/user_entity.dart';
import 'package:intl/intl.dart';

class SignupRequestBody extends UserEntity {
  final String username;
  final DateTime birthDate;
  final String email;
  final String password;
  final String phone;
  final String address;
  final List<String>? roles;
  final String lat;
  final String lng;

  SignupRequestBody({
    required this.email,
    required this.birthDate,
    required this.password,
    required this.username,
    required this.phone,
    required this.address,
    this.roles,
    required this.lat,
    required this.lng,
  }) : super(
            personalInfo: PersonalInfoEntity(
              firstName: username,
              phoneNumber: phone,
              birthDate: birthDate
            ),
            email: email,
            password: password,
            address: address,
            lat: lat,
            lang: lng
            );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'phone': phone,
      'address': address,
      'roles': roles,
      'lat': lat,
      'lng': lng,
    };
  }
}
