import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/api%20manager/api_endpoints.dart';
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
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(registerResponse);
        }
        return Left(
          ServerError(
            errorMessage: response.data['message'] ?? " Server Error",
          ),
        );
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: 'Unhandled Error, Please Try again'));
    }
  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login(
    String? email,
    String? password,
  ) async {
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
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(loginResponseDm);
        }
        return Left(
          ServerError(
            errorMessage: response.data['message'] ?? " Server Error",
          ),
        );
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: 'Unhandled Error, Please Try again'));
    }
  }

  @override
  Future<Either<Failures, ForgetPasswordResponseEntity>> resetPassword(
    String? email,
    String? newPassword,
  ) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          path: ApiEndPoints.resetPassword,
          data: {"email": email, "newPassword": newPassword},
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        ForgetPasswordResponseDm forgetPasswordResponseDm =
            ForgetPasswordResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(forgetPasswordResponseDm);
        }
        return Left(
          ServerError(
            errorMessage: response.data['message'] ?? " Server Error",
          ),
        );
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: 'Unhandled Error, Please Try again'));
    }
  }
}
