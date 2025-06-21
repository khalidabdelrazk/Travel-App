import 'package:either_dart/either.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/Entity/book_now_response_entity.dart';

abstract class BookNowDataSource {
  Future<Either<Failures, BookNowResponseEntity>> bookNow(String tripId, String type);
}
