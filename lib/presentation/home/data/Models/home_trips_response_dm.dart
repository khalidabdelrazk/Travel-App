import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';
import 'package:travel/presentation/trips/domain/Entity/trips_response_entity.dart';

class HomeTripsResponseDm extends HomeTripsResponseEntity{
  HomeTripsResponseDm({
      super.id,
      super.name,
      super.description,
      super.photos,
      super.price,
      super.location,
      super.city,
      super.createdAt,
      super.updatedAt,
      this.v,});

  HomeTripsResponseDm.fromJson(dynamic json) {
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
  }
  int? v;


}