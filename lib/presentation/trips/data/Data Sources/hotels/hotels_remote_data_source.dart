import 'package:either_dart/either.dart';
import 'package:travel/presentation/trips/data/Models/explore_response_dm.dart';
import '../../../../../../core/error/failures.dart';

abstract class HotelsRemoteDataSource {
  Future<Either<Failures, List<ExploreResponseDm>>> getHotels(
    String? controllerText
  );
}
