import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../../../domain/entity/chatbot_response.dart';

abstract class ChatbotDataSource {
  Future<Either<Failures, ChatbotResponseEntity>> getChatbotResponse(
    String? controllerText,
  );
}
