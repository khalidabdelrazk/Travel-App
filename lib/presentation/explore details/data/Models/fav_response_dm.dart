import 'package:travel/presentation/explore%20details/domain/Entity/fav_response_entity.dart';

class FavResponseDm extends FavResponseEntity {
  FavResponseDm({super.message, super.wishlist, super.err});

  FavResponseDm.fromJson(dynamic json) {
    message = json['message'];
    wishlist = json['wishlist'] != null ? json['wishlist'].cast<String>() : [];
    err = json['err'] != null ? ErrDm.fromJson(json['err']) : null;
  }
}

class ErrDm extends ErrEntity {
  ErrDm({super.name, super.message});

  ErrDm.fromJson(dynamic json) {
    name = json['name'];
    message = json['message'];
  }
}
