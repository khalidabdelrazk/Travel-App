import 'package:travel/presentation/chatbot/domain/entity/chatbot_response.dart';

class ChatbotResponseDm extends ChatbotResponseEntity {
  ChatbotResponseDm({super.response});

  ChatbotResponseDm.fromJson(dynamic json) {
    response = json['response'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response'] = response;
    return map;
  }
}
