class ExploreResponseEntity {
  ExploreResponseEntity({
      this.id, 
      this.name, 
      this.description, 
      this.photos, 
      this.price, 
      this.location, 
      this.city, 
      this.rating,
    this.message,
      this.type,});
  String? id;
  String? name;
  String? description;
  List<String>? photos;
  num? price;
  String? location;
  String? city;
  num? rating;
  String? type;
  String? message;
}