import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/api%20manager/api_constants.dart';
import 'package:travel/core/api%20manager/api_endpints.dart';
import 'package:travel/core/error/failures.dart';
import '../../../../../../core/api manager/api_manager.dart';
import '../../../../domain/entity/chatbot_response.dart';
import '../../../model/chatbot_response_dm.dart';
import '../chatbot_data_source.dart';

@Injectable(as: ChatbotDataSource)
class ChatbotDataSourceImpl implements ChatbotDataSource {
  final ApiManager apiManager;
  ChatbotDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, ChatbotResponseEntity>> getChatbotResponse(
    String? controllerText,
  ) async {
    if (controllerText == null || controllerText.trim().isEmpty) {
      return Left(ServerError(errorMessage: "Message cannot be empty"));
    }

    try {
      // Post body format
      final body = {"message": controllerText};

      final response = await apiManager.postData(
        path: ApiEndPoints.chatbot,
        data: body,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // The response.data is assumed to be Map<String, dynamic>
        final data = response.data;

        final chatbotText = data["response"];

        if (chatbotText != null) {
          final chatbotResponse = ChatbotResponseDm(response: chatbotText);
          return Right(chatbotResponse);
        } else {
          return Left(ServerError(errorMessage: "Invalid response format"));
        }
      } else {
        return Left(
          ServerError(errorMessage: "Server error: ${response.statusCode}"),
        );
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}
