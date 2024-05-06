import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/sign-in/data/api/login_api.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setUser(Member user) {
    emit(UserLoaded(user));
  }

  Future<Member?> getUserById(int id) async {
    emit(UserLoading());

    try {
      final response = await LoginHttpClient.getUserById(id);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final member = Member(
          id: responseBody['memberId'],
          name: responseBody['name'].toString(),
          email: responseBody['email'].toString(),
          password: responseBody['password'].toString(),
          organizationIds:
              List<int>.from(responseBody['organizationIds'].map((x) => x)),
        );

        emit(UserSuccess(member));
        return member;
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        emit(const UserFailure(errMessage: "Failed to get user details!"));
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      emit(const UserFailure(errMessage: "Failed to get user details!"));
      return null;
    }
  }

  void logout() {
    emit(UserInitial());
  }
}
