import 'dart:convert';

import 'package:estegatha/features/safety/domain/models/user_health_info.dart';
import 'package:equatable/equatable.dart';
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_health_state.dart';

class UserHealthCubit extends Cubit<UserHealthState> {
  UserHealthCubit() : super(UserHealthInitial());

  Future<void> addUserDisease(String disease) async {
    emit(AddUserDiseaseLoading());

    try {
      final response = await UserHttpClient.addUserDisease(disease);

      if (response.statusCode == 200) {
        emit(AddUserDiseaseSuccess());
        await getUserHealthInfo();
      } else {
        print('Response body: ${response.body}');
        emit(const AddUserDiseaseFailure(errMessage: "Failed to add disease!"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(const AddUserDiseaseFailure(errMessage: "Failed to add disease!"));
    }
  }

  Future<void> addUserMedicine(String medicine) async {
    emit(AddUserMedicineLoading());

    try {
      final response = await UserHttpClient.addUserMedicine(medicine);

      if (response.statusCode == 200) {
        emit(AddUserMedicineSuccess());
        await getUserHealthInfo();
      } else {
        print('Response body: ${response.body}');
        emit(const AddUserMedicineFailure(
            errMessage: "Failed to add medicine!"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(const AddUserMedicineFailure(errMessage: "Failed to add medicine!"));
    }
  }

  Future<UserHealthInfo> getUserHealthInfo() async {
    emit(UserHealthInfoLoading());

    try {
      final response = await UserHttpClient.getUserHealthInfo();

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final userHealthInfo = UserHealthInfo.fromJson(responseBody);

        emit(UserHealthInfoLoaded(userHealthInfo));
        return userHealthInfo;
      } else {
        print('Response body: ${response.body}');
        emit(const UserHealthInfoFailure(
            errMessage: "Failed to get user health info!"));
        return UserHealthInfo();
      }
    } catch (e) {
      print('Exception: $e');
      emit(const UserHealthInfoFailure(
          errMessage: "Failed to get user health info!"));
      return UserHealthInfo();
    }
  }
}
