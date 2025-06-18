import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../Entity/trips_response_entity.dart';

abstract class HomeTripsRepository {

  Future<Either<Failures, List<HomeTripsResponseEntity>>> getTrips();
  Future<Either<Failures, List<HomeTripsResponseEntity>>> getCategoryTrips(String queryParams);
}
