import 'package:either_dart/either.dart';
import 'package:travel/presentation/trips/domain/Entity/trips_response_entity.dart';
import '../../../../../../core/error/failures.dart';

abstract class TripsRemoteDataSource {
  Future<Either<Failures, List<TripsResponseEntity>>> getTrips(
    String? controllerText
  );
}
