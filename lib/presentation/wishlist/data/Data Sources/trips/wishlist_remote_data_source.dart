import 'package:either_dart/either.dart';
import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';
import 'package:travel/presentation/wishlist/domain/Entity/wishlist_response_entity.dart';
import '../../../../../../core/error/failures.dart';

abstract class WishlistRemoteDataSource {
  Future<Either<Failures, List<WishlistResponseEntity>>> getWishlist();
}
