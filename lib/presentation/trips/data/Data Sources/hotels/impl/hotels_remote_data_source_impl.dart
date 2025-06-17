import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/api manager/api_endpints.dart';
import '../../../../../../../core/api manager/api_manager.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../domain/Entity/hotels_response_entity.dart';
import '../hotels_remote_data_source.dart';

@Injectable(as: HotelsRemoteDataSource)
class HotelsRemoteDataSourceImpl implements HotelsRemoteDataSource {
  final ApiManager apiManager;
  HotelsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, List<HotelsResponseEntity>>> getHotels(
    String? controllerText,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    Map<String, dynamic>? queryParams;

    if (controllerText != null && controllerText.trim().isNotEmpty) {
      queryParams = {'city': controllerText};
    }

    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final response = await apiManager.getData(
          path: ApiEndPoints.getHotels,
          queryParameters: queryParams,
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          List<dynamic> jsonList = response.data;
          List<HotelsResponseEntity> trips =
              jsonList
                  .map((item) => HotelsResponseEntity.fromJson(item))
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
