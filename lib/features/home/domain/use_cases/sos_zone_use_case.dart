import 'package:dartz/dartz.dart';
import 'package:estegatha/features/home/domain/entities/sos_zone_entity.dart';
import 'package:estegatha/utils/helpers/failure.dart';
import 'package:estegatha/utils/helpers/no_param_use_case.dart';

import '../repos/sos_zone_repo.dart';

class SosZoneUseCase extends UseCase<List<SosZoneEntity>>{
  final SosZoneRepo _sosZoneRepo;

  SosZoneUseCase(this._sosZoneRepo);
  @override
  Future<Either<Failure, List<SosZoneEntity>>> call() async {
    return await _sosZoneRepo.fetchSosZones();
  }

}