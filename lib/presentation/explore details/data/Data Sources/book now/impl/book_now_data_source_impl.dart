import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/api%20manager/api_manager.dart';
import 'package:travel/core/error/failures.dart';
import 'package:travel/presentation/explore%20details/data/Data%20Sources/book%20now/book_now_data_source.dart';
import 'package:travel/presentation/explore%20details/data/Models/book_now_response_dm.dart';
import '../../../../../../core/api manager/api_endpoints.dart';
import '../../../../../../core/utils/shared_pref_services.dart';


@Injectable(as: BookNowDataSource)
class BookNowDataSourceImpl extends BookNowDataSource{
  ApiManager apiManager;
  BookNowDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures, BookNowResponseDm>> bookNow(
      String tripId,
      String type,
      ) async {
    if (type == 'hotel') {
      return _bookHotel(tripId);
    } else {
      return _bookTrip(tripId);
    }
  }

  Future<Either<Failures, BookNowResponseDm>> _bookHotel(String hotelId) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final token = SharedPrefService.instance.getToken();

        if (token == null) {
          return Left(ServerError(errorMessage: "Invalid Token"));
        }

        final response = await apiManager.postData(
          path: ApiEndPoints.bookHotel(hotelId),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            validateStatus: (status) => true,
          ),
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final BookNowResponseDm bookNowResponseDm = BookNowResponseDm.fromJson(
            response.data,
          );
          return Right(bookNowResponseDm);
        }
        return Left(ServerError(errorMessage: response.data.message!));
      } else {
        return Left(NetworkError(errorMessage: "No internet connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: 'Unhandled Error, Please Try again'));
    }
  }

  Future<Either<Failures, BookNowResponseDm>> _bookTrip(String tripId) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final token = SharedPrefService.instance.getToken();

        if (token == null) {
          return Left(ServerError(errorMessage: "Invalid Token"));
        }

        final response = await apiManager.postData(
          path: ApiEndPoints.bookTrip(tripId),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            validateStatus: (status) => true,
          ),
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final BookNowResponseDm bookNowResponseDm = BookNowResponseDm.fromJson(
            response.data,
          );
          return Right(bookNowResponseDm);
        }
        return Left(ServerError(errorMessage: response.statusCode.toString()));
      } else {
        return Left(NetworkError(errorMessage: "No internet connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: 'Unhandled Error, Please Try again'));
    }
  }

}