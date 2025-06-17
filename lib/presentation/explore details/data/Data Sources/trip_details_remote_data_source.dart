import 'package:either_dart/either.dart';
import '../../../../../core/error/failures.dart';
import '../Models/fav_response_dm.dart';

abstract class TripDetailsRemoteDataSource {
  Future<Either<Failures, FavResponseDm>> fav(
    String? tripId, bool setFav
  );
}
