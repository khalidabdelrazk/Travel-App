import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';
import 'package:travel/presentation/home/domain/Repository/home_repository.dart';
import '../../../../core/error/failures.dart';

@Injectable()
class HomeTripsUseCase {
  final HomeTripsRepository homeTripsRepository;
  HomeTripsUseCase({required this.homeTripsRepository});
  Future<Either<Failures, List<HomeTripsResponseEntity>>> invoke() async {
    final result = await homeTripsRepository.getTrips();

    return result.fold((failure) => Left(failure), (trips) {
      final List<HomeTripsResponseEntity> filteredTrips =
          trips.where((trip) => (trip.rating ?? 0) >= 4).toList();
      return Right(filteredTrips);
    });
  }
}
