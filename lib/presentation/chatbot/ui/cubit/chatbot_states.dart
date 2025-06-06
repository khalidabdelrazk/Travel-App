import 'package:travel/presentation/chatbot/domain/entity/chatbot_response.dart';

abstract class ChatbotStates {}

class ChatbotInitState extends ChatbotStates {}

class ChatbotLoadingState extends ChatbotStates {}

class ChatbotSuccessState extends ChatbotStates {
  ChatbotResponseEntity response;
  ChatbotSuccessState({required this.response});
}

class ChatbotErrorState extends ChatbotStates {
  String errorMessage;
  ChatbotErrorState({required this.errorMessage});
}
