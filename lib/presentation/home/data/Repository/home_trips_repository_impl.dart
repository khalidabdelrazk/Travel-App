import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/home/data/Data%20Sources/trips/home_trips_remote_data_source.dart';
import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';
import 'package:travel/presentation/home/domain/Repository/home_repository.dart';
import '../../../../core/error/failures.dart';

@Injectable(as: HomeTripsRepository)
class HomeTripsRepositoryImpl extends HomeTripsRepository {
  final HomeTripsRemoteDataSource homeTripsRemoteDataSource;
  HomeTripsRepositoryImpl(
    this.homeTripsRemoteDataSource,
  );



  @override
  Future<Either<Failures, List<HomeTripsResponseEntity>>> getTrips(
  ) async {
    var either = await homeTripsRemoteDataSource.getTrips();
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<HomeTripsResponseEntity>>> getCategoryTrips(String queryParams) async{
    var either = await homeTripsRemoteDataSource.getCategoryTrips(queryParams);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
