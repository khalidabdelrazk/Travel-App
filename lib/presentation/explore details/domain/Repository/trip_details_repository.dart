import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../Entity/add_to_fav_response_entity.dart';

abstract class TripDetailsRepository {
  Future<Either<Failures, AddToFavResponseEntity>> addToFav(
    String? tripId, bool setFav
  );
}
