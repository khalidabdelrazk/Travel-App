import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';

class HotelsResponseEntity extends ExploreResponseEntity{
  HotelsResponseEntity({
    super.id,
    super.name,
    super.description,
    super.city,
    super.location,
    super.photos,
    super.price,
    super.rating,
  });

  HotelsResponseEntity.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    location = json['location'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    price = json['price'];
    rating = json['rating'];
  }

}
