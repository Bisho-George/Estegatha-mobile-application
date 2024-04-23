import 'package:flutter/material.dart';

class SignUpViewModel {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  DateTime? birthDate;
  String? phoneNumber;
  String? email;
  String? password;
  String? otp;
  String? address;

  GlobalKey<FormState> get formKey => _formKey;



}