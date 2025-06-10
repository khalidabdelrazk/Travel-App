import 'package:travel/presentation/authentication/Domain/Entity/forget_password_response_entity.dart';

class ForgetPasswordResponseDm extends ForgetPasswordResponseEntity {
  ForgetPasswordResponseDm({super.message, super.error});

  ForgetPasswordResponseDm.fromJson(dynamic json) {
    message = json['message'];
    error = json['error'];
  }
}
