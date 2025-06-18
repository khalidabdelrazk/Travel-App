class FavResponseEntity {
  FavResponseEntity({this.message, this.wishlist,});

  FavResponseEntity.fromJson(dynamic json) {
    message = json['message'];
    wishlist = json['wishlist'] != null ? json['wishlist'].cast<String>() : [];
  }
  String? message;
  List<String>? wishlist;
}

