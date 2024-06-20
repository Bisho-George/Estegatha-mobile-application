import 'package:estegatha/features/sos/data/api/sos_api.dart';
import 'package:estegatha/features/sos/domain/repositories/sos_repo.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/create_pin_status.dart';
import 'package:bloc/bloc.dart';
class CreatePinCubit extends Cubit<CreatePinStatus>{
  CreatePinCubit():super(CreatePinInitial());
  double opacity = 0.6;
  String pin = '';
  void sendPin(){
    emit(CreatePinLoading());
    SosRepo createSosRepo = SosApi();
    createSosRepo.createSosPin(pin).then((value) {
      if(value == 201){
        emit(CreatePinSuccess());
      }else{
        emit(CreatePinFailed(message: 'Failed to create pin'));
      }
      pin = '';
      opacity = 0.6;
    });
  }
}