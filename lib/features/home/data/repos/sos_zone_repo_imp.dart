import 'package:dartz/dartz.dart';
import 'package:estegatha/features/home/data/data_sources/sos_zone_remote_data_source.dart';
import 'package:estegatha/features/home/domain/entities/sos_zone_entity.dart';
import 'package:estegatha/features/home/domain/repos/sos_zone_repo.dart';
import 'package:estegatha/utils/helpers/failure.dart';

import '../data_sources/sos_zones_local_data_source.dart';

class SosZoneRepoImp extends SosZoneRepo {
  final SosZoneRemoteDataSource sosZoneRemoteDataSource;
  final SosZoneLocalDataSource sosZoneLocalDataSource;

  SosZoneRepoImp(this.sosZoneRemoteDataSource, this.sosZoneLocalDataSource);

  @override
  Future<Either<Failure, List<SosZoneEntity>>> fetchSosZones() async {
    try {
      var sosZones = await sosZoneLocalDataSource.fetchSosZones();
      if (sosZones.isNotEmpty) {
        return Right(sosZones);
      } else {
        sosZones = await sosZoneRemoteDataSource.fetchSosZones();
        return Right(sosZones);
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
