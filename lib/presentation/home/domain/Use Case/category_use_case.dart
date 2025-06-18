import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';
import 'package:travel/presentation/home/domain/Repository/home_repository.dart';
import '../../../../core/error/failures.dart';

@Injectable()
class CategoryUseCase {
  final HomeTripsRepository homeTripsRepository;
  CategoryUseCase({required this.homeTripsRepository});

  Future<Either<Failures, List<HomeTripsResponseEntity>>> invoke(String queryParams) async {
    final result = await homeTripsRepository.getCategoryTrips(queryParams);
    return result.fold((failure) => Left(failure), (trips) => Right(trips));
  }
}
