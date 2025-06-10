import 'package:travel/presentation/authentication/Domain/Entity/register_response_entity.dart';

class RegisterResponseDm extends RegisterResponseEntity{
  RegisterResponseDm({super.success, super.userData, super.error});

  RegisterResponseDm.fromJson(dynamic json) {
    success = json['success'];
    error = json['error'];
    userData =
        json['userData'] != null ? UserData.fromJson(json['userData']) : null;
  }



}

class UserData extends UserDataEntity{
  UserData({
    super.name,
    super.email,
    super.phone,
    super.password,
    super.isAdmin,
    this.active,
    this.wishlist,
    super.tokens,
    super.id,
    this.v,
  });

  UserData.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    isAdmin = json['isAdmin'];
    active = json['active'];
    wishlist =
        json['wishlist'] != null ? List<dynamic>.from(json['wishlist']) : null;
    tokens = json['tokens'] != null ? List<dynamic>.from(json['tokens']) : null;
    id = json['_id'];
    v = json['__v'];
  }

  bool? active;
  List<dynamic>? wishlist;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;
    map['isAdmin'] = isAdmin;
    map['active'] = active;
    map['wishlist'] = wishlist;
    map['tokens'] = tokens;
    map['_id'] = id;
    map['__v'] = v;
    return map;
  }
}
