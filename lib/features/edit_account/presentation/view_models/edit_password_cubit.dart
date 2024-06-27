import 'package:bloc/bloc.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_password_state.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_phone_state.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/api/edit_account_api.dart';
import '../../domain/repositories/edit_account_repo.dart';
class EditPasswordCubit extends Cubit<EditPasswordState>{
  bool loading = false;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final EditAccountRepo _editAccountRepo = EditAccountApi();
  EditPasswordCubit():super(EditPasswordInitial());
  void editPassword() async{
    loading = true;
    try{
      if(currentPasswordController.text.isEmpty || newPasswordController.text.isEmpty || rePasswordController.text.isEmpty){
        emit(EditPasswordFailure(message: 'Please fill all fields'));
      }
      else if(currentPasswordController.text == newPasswordController.text){
        emit(EditPasswordFailure(message: 'Old password and new password are the same'));
      }
      else if(newPasswordController.text.length < 8){
        emit(EditPasswordFailure(message: 'Password must be at least 8 characters'));
      }
      else {
        int response = await _editAccountRepo
            .editPassword(currentPasswordController.text, newPasswordController.text)
            .timeout(Duration(seconds: durationTimeout));
        if(response == 0){
          emit(EditPasswordFailure(message: 'Failed to update password'));
        }
        else {
          emit(EditPasswordSuccess(message: 'Password updated successfully'));
        }
      }
    }catch(e){
      emit(EditPasswordFailure(message: 'Failed to update password'));
    }
    currentPasswordController = TextEditingController();
    rePasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    loading = false;
  }
}