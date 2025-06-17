import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../Entity/wishlist_response_entity.dart';

abstract class WishlistRepository {
  Future<Either<Failures, List<WishlistResponseEntity>>> getWishlist();
}
