import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/trips/domain/Repository/explore_repository.dart';
import '../../../../core/error/failures.dart';
import '../Entity/explore_response_entity.dart';

@Injectable()
class HotelsUseCase {
  final ExploreRepository exploreRepository;
  HotelsUseCase({required this.exploreRepository});
  Future<Either<Failures, List<ExploreResponseEntity>>> invoke(
    String? controllerText
  ) {
    return exploreRepository.getHotels(controllerText);
  }
}
