import 'package:either_dart/either.dart';
import '../../../Domain/Entity/failures.dart';
import '../../../Domain/Entity/forget_password_response_entity.dart';
import '../../../Domain/Entity/login_response_entity.dart';
import '../../../Domain/Entity/register_response_entity.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, RegisterResponseEntity>> register(
    String? name,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
  );

  Future<Either<Failures, LoginResponseEntity>> login(
      String? email,
      String? password,
      );

  Future<Either<Failures, ForgetPasswordResponseEntity>> resetPassword(
      String? email,
      String? newPassword,
      );
}
