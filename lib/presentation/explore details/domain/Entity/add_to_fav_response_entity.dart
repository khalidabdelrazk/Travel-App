class AddToFavResponseEntity {
  AddToFavResponseEntity({this.message, this.wishlist, this.err});

  AddToFavResponseEntity.fromJson(dynamic json) {
    message = json['message'];
    wishlist = json['wishlist'] != null ? json['wishlist'].cast<String>() : [];
    err = json['err'] != null ? ErrEntity.fromJson(json['err']) : null;
  }
  String? message;
  List<String>? wishlist;
  ErrEntity? err;
}

class ErrEntity {
  ErrEntity({this.name, this.message});

  ErrEntity.fromJson(dynamic json) {
    name = json['name'];
    message = json['message'];
  }
  String? name;
  String? message;
}
