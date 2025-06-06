import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/chatbot/domain/use%20cases/chatbot_use_cases.dart';
import 'package:travel/presentation/chatbot/ui/cubit/chatbot_states.dart';


@injectable
class ChatBotViewModel extends Cubit<ChatbotStates> {
  final ChatbotUseCases chatbotUseCases;
  ChatBotViewModel({required this.chatbotUseCases}) : super(ChatbotInitState());

  void getTrips(String controllerText) async {
    emit(ChatbotLoadingState());
    var either = await chatbotUseCases.invoke(controllerText);
    either.fold(
      (left) => emit(ChatbotErrorState(errorMessage: left.errorMessage)),
      (right) => emit(ChatbotSuccessState(response: right)),
    );
  }
}
