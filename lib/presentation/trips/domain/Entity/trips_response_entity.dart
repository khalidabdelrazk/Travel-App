import 'explore_response_entity.dart';

class TripsResponseEntity extends ExploreResponseEntity{
  TripsResponseEntity({
    super.id,
    super.name,
    super.description,
    super.photos,
    super.price,
    super.location,
    super.city,
    this.createdAt,
    this.updatedAt,
    super.rating,});

  TripsResponseEntity.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    price = json['price'];
    location = json['location'];
    city = json['city'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    rating = json['rating'];
  }

  String? createdAt;
  String? updatedAt;


}
