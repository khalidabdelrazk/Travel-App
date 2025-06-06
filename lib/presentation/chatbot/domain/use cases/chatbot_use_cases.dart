import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/chatbot/domain/entity/chatbot_response.dart';
import 'package:travel/presentation/chatbot/domain/repository/chatbot_repository.dart';
import '../../../../core/error/failures.dart';

@Injectable()
class ChatbotUseCases {
  final ChatbotRepository chatbotRepository;
  ChatbotUseCases({required this.chatbotRepository});
  Future<Either<Failures, ChatbotResponseEntity>> invoke(String? controllerText) {
    return chatbotRepository.getChatbotResponse(controllerText);
  }
}
