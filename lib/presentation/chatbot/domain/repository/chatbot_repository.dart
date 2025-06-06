import 'package:either_dart/either.dart';
import 'package:travel/presentation/chatbot/domain/entity/chatbot_response.dart';
import '../../../../../../core/error/failures.dart';

abstract class ChatbotRepository {
  Future<Either<Failures, ChatbotResponseEntity>> getChatbotResponse(
    String? controllerText,
  );
}
