class Place {
  final String image;
  final String name;
  final String location;
  final bool isFavorite;
  final String description;
  final int rate;
  final String id;

  Place({
    required this.image,
    required this.name,
    required this.location,
    required this.isFavorite,
    required this.description,
    required this.rate,
    required this.id,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      image: json['image'],
      name: json['name'],
      location: json['location'],
      isFavorite: json['is_favorite'],
      description: json['description'],
      rate: json['rate'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'location': location,
      'is_favorite': isFavorite,
      'description': description,
      'rate': rate,
      'id': id,
    };
  }
}
