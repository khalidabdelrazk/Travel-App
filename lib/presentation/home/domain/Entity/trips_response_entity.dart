class HomeTripsResponseEntity {
  HomeTripsResponseEntity({
      this.id, 
      this.name, 
      this.description, 
      this.photos, 
      this.price, 
      this.location, 
      this.city, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.rating,});

  HomeTripsResponseEntity.fromJson(dynamic json) {
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
    rating = json['rating'];
  }
  String? id;
  String? name;
  String? description;
  List<String>? photos;
  int? price;
  String? location;
  String? city;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['photos'] = photos;
    map['price'] = price;
    map['location'] = location;
    map['city'] = city;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['rating'] = rating;
    return map;
  }

}