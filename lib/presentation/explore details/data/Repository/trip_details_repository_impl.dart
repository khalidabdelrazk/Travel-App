import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/explore%20details/data/Data%20Sources/trip_details_remote_data_source.dart';
import 'package:travel/presentation/explore%20details/domain/Repository/trip_details_repository.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/Entity/fav_response_entity.dart';

@Injectable(as: TripDetailsRepository)
class TripDetailsRepositoryImpl extends TripDetailsRepository {
  final TripDetailsRemoteDataSource tripDetailsRemoteDataSource;
  TripDetailsRepositoryImpl(
    this.tripDetailsRemoteDataSource,
  );

  @override
  Future<Either<Failures, FavResponseEntity>> fav(
    String? tripId, bool setFav
  ) async {
    var either = await tripDetailsRemoteDataSource.fav(tripId,setFav);
    return either.fold((error) => Left(error), (response) => Right(response));
  }

}
