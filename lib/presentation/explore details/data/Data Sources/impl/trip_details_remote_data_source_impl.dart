import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/explore%20details/data/Models/add_to_fav_response_dm.dart';
import '../../../../../../../core/api manager/api_endpints.dart';
import '../../../../../../../core/api manager/api_manager.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../core/utils/shared_pref_services.dart';
import '../../../domain/Entity/add_to_fav_response_entity.dart';
import '../trip_details_remote_data_source.dart';

@Injectable(as: TripDetailsRemoteDataSource)
class TripDetailsRemoteDataSourceImpl implements TripDetailsRemoteDataSource {
  final ApiManager apiManager;
  TripDetailsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, AddToFavResponseEntity>> addToFav(
    String? tripId, bool setFav
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final token = SharedPrefService.instance.getToken();

        if (token == null) {
          return Left(ServerError(errorMessage: "Invalid Token"));
        }

        final response = await apiManager.postData(
          path: ApiEndPoints.setFav(tripId!),
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
          final AddToFavResponseDm addToFavResponseDm =
              AddToFavResponseDm.fromJson(response.data);
          return Right(addToFavResponseDm);
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
