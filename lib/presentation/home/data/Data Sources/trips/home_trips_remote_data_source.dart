import 'package:either_dart/either.dart';
import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';
import '../../../../../../core/error/failures.dart';

abstract class HomeTripsRemoteDataSource {
  Future<Either<Failures, List<HomeTripsResponseEntity>>> getTrips();
}
