import 'package:either_dart/either.dart';
import 'package:travel/presentation/trips/domain/Entity/hotels_response_entity.dart';
import '../../../../../../core/error/failures.dart';

abstract class HotelsRemoteDataSource {
  Future<Either<Failures, List<HotelsResponseEntity>>> getHotels(
    String? controllerText
  );
}
