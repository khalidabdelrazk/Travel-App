import 'package:travel/presentation/explore%20details/domain/Entity/fav_response_entity.dart';

class FavResponseDm extends FavResponseEntity {
  FavResponseDm({super.message, super.wishlist,});

  FavResponseDm.fromJson(dynamic json) {
    message = json['message'];
    wishlist = json['wishlist'] != null ? json['wishlist'].cast<String>() : [];
  }
}

