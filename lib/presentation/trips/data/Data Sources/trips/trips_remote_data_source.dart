import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../../../domain/Entity/explore_response_entity.dart';

abstract class TripsRemoteDataSource {
  Future<Either<Failures, List<ExploreResponseEntity>>> getTrips(
    String? controllerText
  );
}
