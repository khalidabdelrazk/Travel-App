import 'package:travel/presentation/trips/domain/Entity/hotels_response_entity.dart';

class HotelsResponseDm extends HotelsResponseEntity {
  HotelsResponseDm({
    super.id,
    super.name,
    super.description,
    super.city,
    super.location,
    super.photos,
    super.price,
    super.rating,
    this.v,
  });

  HotelsResponseDm.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    location = json['location'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    price = json['price'];
    rating = json['rating'];
    v = json['__v'];
  }
  int? v;
}
