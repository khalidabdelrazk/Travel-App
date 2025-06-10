class LoginResponseEntity {
  LoginResponseEntity({
    this.success,
    this.token,
    this.name,});

  LoginResponseEntity.fromJson(dynamic json) {
    success = json['success'];
    token = json['token'];
    name = json['name'];
    message = json['message'];
  }
  bool? success;
  String? token;
  String? name;
  String? message;

}