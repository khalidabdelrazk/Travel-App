import 'package:travel/presentation/wishlist/domain/Entity/wishlist_response_entity.dart';

class WishlistResponseDm extends WishlistResponseEntity {
  WishlistResponseDm({
    super.id,
    super.name,
    super.description,
    super.photos,
    super.price,
    super.location,
    super.city,
    super.createdAt,
    super.updatedAt,
    this.v,
    super.rating,
    this.type,
    this.message,
  });

  WishlistResponseDm.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    price = json['price'];
    location = json['location'];
    city = json['city'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    rating = json[' rating'];
    type = json['type'];
    message = json['message'];
  }
  num? v;
  String? type;
  String? message;
}


/*
  {
  message : snlafkan
    err : {
          msg : invalid token
           }
 }

 */