class TourResponseEntity {
  TourResponseEntity({
      this.name, 
      this.description, 
      this.city, 
      this.location, 
      this.photos, 
      this.price, 
      this.rating, 
      this.type, 
      this.message,
      this.id,
      this.v,});

  TourResponseEntity.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    city = json['city'];
    location = json['location'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    price = json['price'];
    rating = json['rating'];
    type = json['type'];
    id = json['_id'];
    v = json['__v'];
  }
  String? name;
  String? description;
  String? city;
  String? location;
  List<String>? photos;
  num? price;
  num? rating;
  String? type;
  String? id;
  String? message;
  num? v;


}