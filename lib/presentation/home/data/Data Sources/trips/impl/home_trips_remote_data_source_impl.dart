import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/api manager/api_endpints.dart';
import '../../../../../../../core/api manager/api_manager.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../domain/Entity/trips_response_entity.dart';
import '../home_trips_remote_data_source.dart';

@Injectable(as: HomeTripsRemoteDataSource)
class HomeTripsRemoteDataSourceImpl implements HomeTripsRemoteDataSource {
  final ApiManager apiManager;
  HomeTripsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, List<HomeTripsResponseEntity>>> getTrips() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final response = await apiManager.getData(
          path: ApiEndPoints.getTrips,
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          List<dynamic> jsonList = response.data;
          List<HomeTripsResponseEntity> trips =
              jsonList
                  .map((item) => HomeTripsResponseEntity.fromJson(item))
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
