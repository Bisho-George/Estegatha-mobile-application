import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future checkEmail({required String email}) async {
    emit(ForgetPasswordLoading());
    try {
      // TODO => http request for cheack email with (email)
      await Future.delayed(const Duration(seconds: 1));
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordFailure(errMessage: "Email not found!"));
      return;
    }
  }
}
