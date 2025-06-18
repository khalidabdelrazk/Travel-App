import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';

class HomeTripsResponseDm extends HomeTripsResponseEntity{
  HomeTripsResponseDm({
    super.id,
    super.name,
    super.description,
    super.photos,
    super.price,
    super.location,
    super.city,
    this.v,
    super.message,
    super.rating,
    super.type,});

  HomeTripsResponseDm.fromJson(dynamic json) {
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