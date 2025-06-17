import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/wishlist/data/Data%20Sources/trips/wishlist_remote_data_source.dart';
import 'package:travel/presentation/wishlist/domain/Entity/wishlist_response_entity.dart';
import 'package:travel/presentation/wishlist/domain/Repository/wishlist_repository.dart';
import '../../../../core/error/failures.dart';

@Injectable(as: WishlistRepository)
class WishlistRepositoryImpl extends WishlistRepository {
  final WishlistRemoteDataSource wishlistRemoteDataSource;
  WishlistRepositoryImpl(
    this.wishlistRemoteDataSource,
  );



  @override
  Future<Either<Failures, List<WishlistResponseEntity>>> getWishlist(
  ) async {
    var either = await wishlistRemoteDataSource.getWishlist();
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
