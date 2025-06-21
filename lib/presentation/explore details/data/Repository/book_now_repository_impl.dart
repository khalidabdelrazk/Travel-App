import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/Entity/book_now_response_entity.dart';
import '../../domain/Repository/book_now_repository.dart';
import '../Data Sources/book now/book_now_data_source.dart';

@Injectable(as: BookNowRepository)
class BookNowRepositoryImpl extends BookNowRepository{
  BookNowDataSource bookNowDataSource;
  BookNowRepositoryImpl({required this.bookNowDataSource});
  @override
  Future<Either<Failures, BookNowResponseEntity>> bookNow(String tripId, String type) async{
    var either = await bookNowDataSource.bookNow(tripId, type);
    return either.fold((error) => Left(error), (response) => Right(response));
  }

}