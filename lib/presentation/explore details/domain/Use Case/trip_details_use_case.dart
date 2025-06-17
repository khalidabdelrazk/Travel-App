import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/explore%20details/domain/Repository/trip_details_repository.dart';
import '../../../../core/error/failures.dart';
import '../Entity/fav_response_entity.dart';

@Injectable()
class TripDetailsUseCase {
  final TripDetailsRepository tripDetailsRepository;
  TripDetailsUseCase({required this.tripDetailsRepository});
  Future<Either<Failures, FavResponseEntity>> invoke(
    String? tripId, bool setFav
  ) {
    return tripDetailsRepository.fav(tripId, setFav);
  }
}
