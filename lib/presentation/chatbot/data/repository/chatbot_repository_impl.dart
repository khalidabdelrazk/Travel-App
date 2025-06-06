import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/chatbot/data/data%20source/server/chatbot_data_source.dart';
import 'package:travel/presentation/chatbot/domain/repository/chatbot_repository.dart';
import 'package:travel/presentation/trips/domain/Repository/explore_repository.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/entity/chatbot_response.dart';

@Injectable(as: ChatbotRepository)
class ChatbotRepositoryImpl extends ChatbotRepository {
  final ChatbotDataSource chatbotDataSource;
  ChatbotRepositoryImpl(this.chatbotDataSource);

  @override
  Future<Either<Failures, ChatbotResponseEntity>> getChatbotResponse(
    String? controllerText,
  ) {
    return chatbotDataSource.getChatbotResponse(controllerText);
  }
}
