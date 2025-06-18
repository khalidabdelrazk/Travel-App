import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:travel/core/api%20manager/api_endpoints.dart';
import '../../../../../../../core/api manager/api_manager.dart';
import '../../../../../../../core/error/failures.dart';
import '../../Models/tour_response_dm.dart';
import '../administrator_remote_data_source.dart';

@Injectable(as: AdministratorRemoteDataSource)
class AdministratorRemoteDataSourceImpl
    implements AdministratorRemoteDataSource {
  final ApiManager apiManager;
  AdministratorRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, TourResponseDm>> postTour({
    required String name,
    required String description,
    required String price,
    required String location,
    required String city,
    required String type,
    required double rating,
    required List<File> photos,
  }) async {
    if (type == "hotel") {
      return _postHotel(
        name: name,
        description: description,
        price: price,
        location: location,
        city: city,
        type: type,
        rating: rating,
        photos: photos,
      );
    } else {
      return _postTrip(
        name: name,
        description: description,
        price: price,
        location: location,
        city: city,
        type: type,
        rating: rating,
        photos: photos,
      );
    }
  }

  Future<Either<Failures, TourResponseDm>> _postTrip({
    required String name,
    required String description,
    required String price,
    required String location,
    required String city,
    required String type,
    required double rating,
    required List<File> photos,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final formData = FormData.fromMap({
          'name': name,
          'description': description,
          'price': price,
          'location': location,
          'city': city,
          'type': type,
          'rating': rating.toString(),
          'photos': await Future.wait(
            photos.map(
              (photo) => MultipartFile.fromFile(
                photo.path,
                filename: p.basename(photo.path),
                contentType: MediaType('image', 'jpeg'),
              ),
            ),
          ),
        });

        final response = await apiManager.postData(
          path: ApiEndPoints.postTrip, // should be "/hotel/" or full URL
          data: formData,
          options: Options(contentType: 'multipart/form-data'),
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final TourResponseDm tourResponseDm = TourResponseDm.fromJson(
            response.data,
          );
          return Right(tourResponseDm);
        }
        return Left(ServerError(errorMessage: response.data.message));
      } else {
        return Left(NetworkError(errorMessage: "No internet connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failures, TourResponseDm>> _postHotel({
    required String name,
    required String description,
    required String price,
    required String location,
    required String city,
    required String type,
    required double rating,
    required List<File> photos,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final formData = FormData.fromMap({
          'name': name,
          'description': description,
          'price': price,
          'location': location,
          'city': city,
          'type': type,
          'rating': rating.toString(),
          'photos': await Future.wait(
            photos.map(
              (photo) => MultipartFile.fromFile(
                photo.path,
                filename: p.basename(photo.path),
                contentType: MediaType('image', 'jpeg'),
              ),
            ),
          ),
        });

        final response = await apiManager.postData(
          path: ApiEndPoints.postHotel, // should be "/hotel/" or full URL
          data: formData,
          options: Options(contentType: 'multipart/form-data'),
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final TourResponseDm tourResponseDm = TourResponseDm.fromJson(
            response.data,
          );
          return Right(tourResponseDm);
        }
        return Left(ServerError(errorMessage: response.data.message));
      } else {
        return Left(NetworkError(errorMessage: "No internet connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}

/*
final connectivityResult = await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final token = SharedPrefService.instance.getToken();

        if (token == null) {
          return Left(ServerError(errorMessage: "Invalid Token"));
        }

        final response = await apiManager.deleteData(
          path: ApiEndPoints.notFav(tripId!),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            validateStatus: (status) => true,
          ),
        );
        print(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final TourResponseDm tourResponseDm = TourResponseDm.fromJson(
            response.data,
          );
          return Right(tourResponseDm);
        }
        return Left(ServerError(errorMessage: response.data.message));
      } else {
        return Left(NetworkError(errorMessage: "No internet connection"));
      }
    } catch (e) {
      // rethrow;
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
 */
