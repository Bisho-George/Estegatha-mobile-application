import 'package:bloc/bloc.dart';
import 'package:estegatha/features/home/domain/use_cases/sos_zone_use_case.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/sos_zone_entity.dart';

part 'sos_zones_state.dart';

class SosZonesCubit extends Cubit<SosZonesState> {
  SosZonesCubit(this.sosZoneUseCase) : super(SosZonesInitial());
  final SosZoneUseCase sosZoneUseCase;

  Future<void> getSosZones() async {
    emit(SosZonesLoading());
    var result = await sosZoneUseCase.call();
    result.fold((failure) {
      emit(SosZonesFailure(failure.message));
    }, (result) {
      emit(SosZonesSuccess(result));
    });
  }
}
