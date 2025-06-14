import 'package:either_dart/either.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/Entity/add_to_fav_response_entity.dart';

abstract class TripDetailsRemoteDataSource {
  Future<Either<Failures, AddToFavResponseEntity>> addToFav(
    String? tripId, bool setFav
  );
}
