import 'package:travel/presentation/explore%20details/domain/Entity/book_now_response_entity.dart';

abstract class BookNowStates{}
class BookNowInitState extends BookNowStates{}
class BookNowLoadingState extends BookNowStates{}
class BookNowErrorState extends BookNowStates{
  String? errorMessage;
  BookNowErrorState({this.errorMessage});
}
class BookNowSuccessState extends BookNowStates{
  BookNowResponseEntity bookNowResponseEntity;
  BookNowSuccessState({required this.bookNowResponseEntity});
}