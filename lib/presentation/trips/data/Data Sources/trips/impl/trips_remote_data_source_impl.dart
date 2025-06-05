import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/api manager/api_endpints.dart';
import '../../../../../../../core/api manager/api_manager.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../domain/Entity/hotels_response_entity.dart';
import '../../../../domain/Entity/trips_response_entity.dart';
import '../trips_remote_data_source.dart';

@Injectable(as: TripsRemoteDataSource)
class TripsRemoteDataSourceImpl implements TripsRemoteDataSource {
  final ApiManager apiManager;
  TripsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, List<TripsResponseEntity>>> getTrips(
      String? controllerText) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final response =
        await apiManager.getData(endPoints: ApiEndPoints.getTrips);

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          List<dynamic> jsonList = response.data;
          List<TripsResponseEntity> trips = jsonList
              .map((item) => TripsResponseEntity.fromJson(item))
              .toList();
          return Right(trips);
        }
        return Left(ServerError(errorMessage: 'Server error'));
      } else {
        return Left(NetworkError(errorMessage: "No internet connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}
