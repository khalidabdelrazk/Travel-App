import 'package:either_dart/either.dart';
import 'package:travel/presentation/trips/domain/Entity/hotels_response_entity.dart';
import '../../../../../../core/error/failures.dart';
import '../Entity/trips_response_entity.dart';

abstract class HomeTripsRepository {

  Future<Either<Failures, List<HomeTripsResponseEntity>>> getTrips(
  );
}
