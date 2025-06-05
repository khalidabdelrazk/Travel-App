import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/trips/domain/Entity/hotels_response_entity.dart';
import 'package:travel/presentation/trips/domain/Entity/trips_response_entity.dart';
import 'package:travel/presentation/trips/domain/Repository/explore_repository.dart';
import '../../../../core/error/failures.dart';

@Injectable()
class TripsUseCase {
  final ExploreRepository exploreRepository;
  TripsUseCase({required this.exploreRepository});
  Future<Either<Failures, List<TripsResponseEntity>>> invoke(
    String? controllerText
  ) {
    return exploreRepository.getTrips(controllerText);
  }
}
