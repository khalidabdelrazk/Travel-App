import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/utils/shared_pref_services.dart';
import '../../../../../../../core/api manager/api_manager.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../../core/api manager/api_endpints.dart';
import '../../../Models/wishlist_response_dm.dart';
import '../wishlist_remote_data_source.dart';

@Injectable(as: WishlistRemoteDataSource)
class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final ApiManager apiManager;
  WishlistRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, List<WishlistResponseDm>>> getWishlist() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        String? token = SharedPrefService.instance.getToken();

        if (token == null) {
          return Left(ServerError(errorMessage: 'Invalid Token'));
        }

        final response = await apiManager.getData(
          path: ApiEndPoints.getWishlist,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            validateStatus: (status) => true,
          ),
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          List<dynamic> jsonList = response.data;
          List<WishlistResponseDm> trip =
              jsonList
                  .map((item) => WishlistResponseDm.fromJson(item))
                  .toList();
          return Right(trip);
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
