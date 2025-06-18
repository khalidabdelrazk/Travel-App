import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';

class ExploreResponseDm extends ExploreResponseEntity{
  ExploreResponseDm({
      super.id,
      super.name,
      super.description,
      super.photos,
      super.price,
      super.location,
      super.city,
      super.message,
      this.v,
      super.rating,
      super.type,});

  ExploreResponseDm.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    price = json['price'];
    location = json['location'];
    city = json['city'];
    v = json['__v'];
    rating = json['rating'];
    type = json['type'];
    message = json['message'];
  }
  num? v;
}