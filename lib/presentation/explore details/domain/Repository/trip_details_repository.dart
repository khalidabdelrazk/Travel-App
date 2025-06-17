import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../Entity/fav_response_entity.dart';

abstract class TripDetailsRepository {
  Future<Either<Failures, FavResponseEntity>> fav(
    String? tripId, bool setFav
  );
}
