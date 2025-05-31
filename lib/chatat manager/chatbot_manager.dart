import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotManager{

  static Future<http.Response?> sendMessage(String message) async {
    final response = await http.post(
      // Uri.parse('http://127.0.0.1:5000/chat'),
      Uri.parse('http://192.168.1.87:5000/chat'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": message}),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

}