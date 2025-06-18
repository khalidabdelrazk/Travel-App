class RegisterResponseEntity {
  RegisterResponseEntity({this.success, this.userData, this.message});

  RegisterResponseEntity.fromJson(dynamic json) {
    success = json['success'];
    message = json['error'];
    userData =
    json['userData'] != null ? UserDataEntity.fromJson(json['userData']) : null;
  }

  bool? success;
  UserDataEntity? userData;
  String? message;

}

class UserDataEntity {
  UserDataEntity({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.isAdmin,
    this.tokens,
    this.id,
  });

  UserDataEntity.fromJson(dynamic json) {
    name = json['name'];
    isAdmin = json['isAdmin'];
    tokens = json['tokens'] != null ? List<dynamic>.from(json['tokens']) : null;
    id = json['_id'];
  }

  String? name;
  String? email;
  String? phone;
  String? password;
  bool? isAdmin;
  List<dynamic>? tokens;
  String? id;

}
