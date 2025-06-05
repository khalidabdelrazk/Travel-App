class ExploreResponseEntity {
  ExploreResponseEntity({
    this.id,
    this.name,
    this.description,
    this.city,
    this.location,
    this.photos,
    this.price,
    this.rating,
  });

  String? id;
  String? name;
  String? description;
  String? city;
  String? location;
  List<String>? photos;
  int? price;
  dynamic rating;
}
