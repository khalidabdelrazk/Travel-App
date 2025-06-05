class ExploreResponseEntity {
  ExploreResponseEntity({
    this.id,
    this.name,
    this.description,
    this.photos,
    this.price,
    this.location,
    this.city,
  });

  String? id;
  String? name;
  String? description;
  List<String>? photos;
  int? price;
  String? location;
  String? city;
}
