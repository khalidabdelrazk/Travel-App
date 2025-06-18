import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../Entity/explore_response_entity.dart';

abstract class ExploreRepository {
  Future<Either<Failures, List<ExploreResponseEntity>>> getHotels(
    String? controllerText,
  );
  Future<Either<Failures, List<ExploreResponseEntity>>> getTrips(
    String? controllerText,
  );
}
