import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/wishlist/domain/Entity/wishlist_response_entity.dart';
import '../../../../core/error/failures.dart';
import '../Repository/wishlist_repository.dart';

@Injectable()
class WishlistUseCase {
  final WishlistRepository wishlistRepository;
  WishlistUseCase({required this.wishlistRepository});
  Future<Either<Failures, List<WishlistResponseEntity>>> invoke() {
    return wishlistRepository.getWishlist();
  }
}
