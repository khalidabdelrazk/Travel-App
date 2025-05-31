import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel/screens/root/chatbot/widgets/loading_dots.dart';
import 'package:travel/screens/root/chatbot/widgets/preview_message.dart';

import '../../../chatat manager/chatbot_manager.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  ScrollController listViewController = ScrollController();
  bool _isBotTyping = false;

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"text": text, "isSender": true, "time": _currentTime()});
      _isBotTyping = true;
    });

    _controller.clear();
    _scrollToBottom(); // Scroll after user message

    try {
      var response = await ChatbotManager.sendMessage(text);
      if (response != null) {
        setState(() {
          _messages.add({
            'text': jsonDecode(response.body)["response"],
            "isSender": false,
            "time": _currentTime(),
          });
        });
      } else {
        _showError("Bot didn't respond");
      }
    } catch (e) {
      // throw e;
      _showError("Failed to send message: $e");
    }
    setState(() {
      _isBotTyping = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // var response = await ChatbotManager.sendMessage(text);
    // setState(() {
    //   _isBotTyping = false;
    // });
    // if (response != null) {
    //   _messages.add({
    //     'text': response.body,
    //     "isSender": false,
    //     "time": _currentTime(),
    //   });
    //
    //   // Scroll after bot message is added and UI is updated
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _scrollToBottom();
    //   });
    // }
  }

  void _showError(String errorMsg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMsg)));
  }

  String _currentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listViewController.hasClients) {
        listViewController.animateTo(
          listViewController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const ChatPreviewAppBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: listViewController,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _messages.length + (_isBotTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isBotTyping && index == _messages.length) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: LoadingDots(),
                  );
                }
                final msg = _messages[index];
                return PreviewMessageBubble(
                  text: msg['text'],
                  time: msg['time'],
                  isSender: msg['isSender'],
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
                    style: TextTheme.of(context).labelLarge,
                    controller: _controller,
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


