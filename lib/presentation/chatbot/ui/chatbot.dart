import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/utils/shared_pref_services.dart';
import 'package:travel/presentation/chatbot/ui/widget/chat_preview_app_bar.dart';
import 'package:travel/presentation/chatbot/ui/widget/preview_message.dart';
import 'package:travel/presentation/chatbot/ui/cubit/chatbot_states.dart';
import 'package:travel/presentation/chatbot/ui/cubit/chatbot_view_model.dart';
import '../../../core/di/di.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];

  final ChatBotViewModel chatBotViewModel = getIt<ChatBotViewModel>();


  @override
  void initState() {
    super.initState();
    // Add default welcome message from bot
    _messages.add({
      "text": "Hey ${SharedPrefService.instance.getName() ?? 'Khalid'}, how can I help you?",
      "isSender": false,
      "time": _currentTime(),
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        "text": text.trim(),
        "isSender": true,
        "time": _currentTime(),
      });
    });

    chatBotViewModel.getTrips(text.trim());
    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatPreviewAppBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBotViewModel, ChatbotStates>(
              bloc: chatBotViewModel,
              listener: (context, state) async {
                if (state is ChatbotSuccessState) {
                  // Show typing message
                  setState(() {
                    _messages.add({
                      "text": "Chatbot is Typing...",
                      "isSender": false,
                      "time": _currentTime(),
                      "isTyping": true,
                    });
                  });
                  _scrollToBottom();

                  // Wait 500ms
                  await Future.delayed(const Duration(milliseconds: 500));

                  // Replace typing with real response
                  setState(() {
                    _messages.removeWhere((msg) => msg['isTyping'] == true);
                    _messages.add({
                      "text": state.response.response,
                      "isSender": false,
                      "time": _currentTime(),
                    });
                  });

                  _scrollToBottom();
                } else if (state is ChatbotErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return PreviewMessageBubble(
                      text: msg['text'],
                      time: msg['time'],
                      isSender: msg['isSender'],
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextTheme.of(context).labelLarge,
                    decoration: InputDecoration(
                      hintText: "Type your message here...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _controller.clear();
                          FocusScope.of(context).unfocus();
                        },
                      )
                          : null,
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton.small(
                  backgroundColor: const Color(0xFF4361EE),
                  onPressed: () => _sendMessage(_controller.text),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
