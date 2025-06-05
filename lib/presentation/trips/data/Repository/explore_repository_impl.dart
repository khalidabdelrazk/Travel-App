import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/trips/data/Data%20Sources/trips/trips_remote_data_source.dart';
import 'package:travel/presentation/trips/domain/Entity/hotels_response_entity.dart';
import 'package:travel/presentation/trips/domain/Repository/explore_repository.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/Entity/trips_response_entity.dart';
import '../Data Sources/hotels/hotels_remote_data_source.dart';

@Injectable(as: ExploreRepository)
class ExploreRepositoryImpl extends ExploreRepository {
  final HotelsRemoteDataSource hotelsRemoteDataSource;
  final TripsRemoteDataSource tripsRemoteDataSource;
  ExploreRepositoryImpl(
    this.hotelsRemoteDataSource,
    this.tripsRemoteDataSource,
  );

  @override
  Future<Either<Failures, List<HotelsResponseEntity>>> getHotels(
    String? controllerText,
  ) async {
    var either = await hotelsRemoteDataSource.getHotels(controllerText);
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<TripsResponseEntity>>> getTrips(
    String? controllerText,
  ) async {
    var either = await tripsRemoteDataSource.getTrips(controllerText);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
