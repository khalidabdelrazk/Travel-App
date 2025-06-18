import 'package:travel/presentation/administrator/domain/Entity/administrator_response_entity.dart';

class TourResponseDm extends TourResponseEntity{
  TourResponseDm({
      super.name,
      super.description,
      super.city,
      super.location,
      super.photos,
      super.price,
      super.rating,
      super.message,
      super.type,
      super.id,
      super.v,});

  TourResponseDm.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    city = json['city'];
    location = json['location'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    price = json['price'];
    rating = json['rating'];
    type = json['type'];
    message = json['message'];
    id = json['_id'];
    v = json['__v'];
  }


}