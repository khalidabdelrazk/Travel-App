import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/authentication/Domain/Entity/forget_password_response_entity.dart';
import '../Entity/failures.dart';
import '../Entity/login_response_entity.dart';
import '../Entity/register_response_entity.dart';
import '../Repository/auth_repository.dart';

// @Injectable()
@injectable
class AuthUseCase {
  final AuthRepository authRepository;
  AuthUseCase({required this.authRepository});
  Future<Either<Failures, RegisterResponseEntity>> registerInvoke(
    String? name,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
  ) {
    return authRepository.register(name, email, password, rePassword, phone);
  }

  Future<Either<Failures, LoginResponseEntity>> loginInvoke(
    String? email,
    String? password,
  ) {
    return authRepository.login(email, password);
  }

  Future<Either<Failures, ForgetPasswordResponseEntity>> resetPasswordInvoke(
    String? email,
    String? newPassword,
  ) {
    return authRepository.resetPassword(email, newPassword);
  }
}
