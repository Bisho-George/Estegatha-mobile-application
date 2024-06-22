import 'package:dio/dio.dart';

String successMessage = 'Phone number has been updated successfully';
String failedMessage = 'Failed to update phone number';
abstract class EditAccountRepo {
  Future<int> editPhone(String phone);
  Future<int> editPassword(String oldPassword, String newPassword);
}