import '../../Domain/Entity/login_response_entity.dart';

class LoginResponseDm extends LoginResponseEntity{
  LoginResponseDm({
    super.success,
    super.token,
    super.name,
  });

  LoginResponseDm.fromJson(dynamic json) {
    success = json['success'];
    token = json['token'];
    name = json['name'];
    message = json['message'];
  }
}

