import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future loginWithEmail(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      // TODO => http request for login with (email, password)
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginFailure(errMessage: "Login with email failed!"));
    } catch (e) {
      emit(LoginSuccess());
      return;
    }
  }

  Future loginWithPhone(
      {required String phone, required String password}) async {
    emit(LoginLoading());
    try {
      // TODO => http request for login with (email, password)
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(errMessage: "Login with phone failed!"));
      return;
    }
  }
}
