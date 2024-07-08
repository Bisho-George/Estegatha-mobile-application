import 'package:dartz/dartz.dart';
import 'package:estegatha/features/add_place/data/data_source/boundary_remote_data_source.dart';
import 'package:estegatha/features/add_place/data/models/organization_boundary_response.dart';
import 'package:estegatha/features/add_place/domain/entities/organization_boundary_entity.dart';
import 'package:estegatha/features/add_place/domain/repos/boundary_repo.dart';
import 'package:estegatha/features/sign-up/data/failure/failure.dart';

class BoundaryRepoImp extends BoundaryRepo {
  final BoundaryRemoteDataSource boundaryRemoteDataSource;

  BoundaryRepoImp(this.boundaryRemoteDataSource);

  @override
  Future<Either<Failure, OrganizationBoundaryResponse>> addPlace(
      num id, OrganizationBoundaryEntity organizationBoundaryEntity) async {
    try {
      var result = await boundaryRemoteDataSource.addPlace(
          id, organizationBoundaryEntity);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrganizationBoundaryEntity>>> getBoundaries(num id) async {
    try {
      var result = await boundaryRemoteDataSource.getBoundaries(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
