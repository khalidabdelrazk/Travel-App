import 'package:travel/presentation/explore%20details/domain/Entity/book_now_response_entity.dart';

class BookNowResponseDm extends BookNowResponseEntity {
  BookNowResponseDm({super.message});

  BookNowResponseDm.fromJson(dynamic json) {
    message = json['message'];
  }
}
