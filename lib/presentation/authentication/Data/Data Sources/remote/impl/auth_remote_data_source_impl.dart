import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/api%20manager/api_constants.dart';
import 'package:travel/core/api%20manager/api_endpints.dart';
import 'package:travel/presentation/authentication/Data/Models/forget_password_response_dm.dart';
import 'package:travel/presentation/authentication/Domain/Entity/forget_password_response_entity.dart';

import '../../../../../../core/api manager/api_manager.dart';
import '../../../../Domain/Entity/failures.dart';
import '../../../../Domain/Entity/login_response_entity.dart';
import '../../../../Domain/Entity/register_response_entity.dart';
import '../../../Models/login_response_dm.dart';
import '../../../Models/register_response_dm.dart';
import '../auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;
  AuthRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, RegisterResponseEntity>> register(
    String? name,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
  ) async {
    print(
      'name: $name,email: $email,password: $password,rePassword: $rePassword,phone: $phone,',
    );
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          path: ApiEndPoints.register,
          data: {
            "name": name,
            "email": email,
            "password": password,
            "cpassword": rePassword,
            "phone": phone,
          },
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        RegisterResponseDm registerResponse = RegisterResponseDm.fromJson(
          response.data,
        );
        print("RESPONSE BODY: ${response.data}");
        print("STATUS CODE: ${response.statusCode}");
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(registerResponse);
        }
        return Left(ServerError(errorMessage: registerResponse.error!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      print('Hello');
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login(
    String? email,
    String? password,
  ) async {
    print('email: $email,password: $password,');
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          path: ApiEndPoints.login,
          data: {"email": email, "password": password},
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        LoginResponseDm loginResponseDm = LoginResponseDm.fromJson(
          response.data,
        );
        print("RESPONSE BODY: ${response.data}");
        print("STATUS CODE: ${response.statusCode}");
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(loginResponseDm);
        }
        return Left(ServerError(errorMessage: loginResponseDm.message!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      print('Hello');
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, ForgetPasswordResponseEntity>> resetPassword(
    String? email,
    String? newPassword,
  ) async {
    print('email: $email,password: $newPassword,');
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          path: ApiConstants.baseUrl + ApiEndPoints.resetPassword,
          data: {"email": email, "newPassword": newPassword},
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        ForgetPasswordResponseDm forgetPasswordResponseDm =
            ForgetPasswordResponseDm.fromJson(response.data);
        print("RESPONSE BODY: ${response.data} , reseeeeeeeeeeeeeeeet");
        print("STATUS CODE: ${response.statusCode}, , reseeeeeeeeeeeeeeeet");
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(forgetPasswordResponseDm);
        }
        return Left(
          ServerError(errorMessage: forgetPasswordResponseDm.message!),
        );
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      print('Hello');
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}
