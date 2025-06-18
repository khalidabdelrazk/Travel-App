import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../../Models/home_trips_response_dm.dart';

abstract class HomeTripsRemoteDataSource {
  Future<Either<Failures, List<HomeTripsResponseDm>>> getTrips();
  Future<Either<Failures, List<HomeTripsResponseDm>>> getCategoryTrips(String queryParams);
}
