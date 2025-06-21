import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/explore%20details/domain/Entity/book_now_response_entity.dart';
import 'package:travel/presentation/explore%20details/domain/Repository/book_now_repository.dart';
import '../../../../core/error/failures.dart';

@injectable
class BookNowUseCase {
  final BookNowRepository bookNowRepository;
  BookNowUseCase({required this.bookNowRepository});
  Future<Either<Failures, BookNowResponseEntity>> invoke(
      String tripId, String type
      ) {
    return bookNowRepository.bookNow(tripId, type);
  }
}
