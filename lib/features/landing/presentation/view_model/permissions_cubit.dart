import 'package:estegatha/features/landing/presentation/view_model/permissions_state.dart';
import 'package:bloc/bloc.dart';

import '../../domain/models/permissions.dart';
class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionStateInitial());

  void grantPermissions() async {
    try {
      await Permissions().grantPermissions();
    } catch (e) {
      print(e);
    }
    emit(PermissionStateFinished());
  }
}