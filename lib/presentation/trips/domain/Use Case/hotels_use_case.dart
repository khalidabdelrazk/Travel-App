import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/trips/domain/Entity/hotels_response_entity.dart';
import 'package:travel/presentation/trips/domain/Repository/explore_repository.dart';
import '../../../../core/error/failures.dart';

@Injectable()
class HotelsUseCase {
  final ExploreRepository exploreRepository;
  HotelsUseCase({required this.exploreRepository});
  Future<Either<Failures, List<HotelsResponseEntity>>> invoke(
    String? controllerText
  ) {
    return exploreRepository.getHotels(controllerText);
  }
}
