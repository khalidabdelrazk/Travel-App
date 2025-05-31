import 'package:flutter/material.dart';

import '../../../../theme/color.dart';

class PreviewMessageBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isSender;

  const PreviewMessageBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: isSender ? 60.0 : 12.0,
          right: isSender ? 12.0 : 60.0,
        ),
        child: Column(
          crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: isSender ? sendMessageLightColor : receiveMessageLightColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: isSender ? const Radius.circular(10) : const Radius.circular(0),
                  bottomRight: isSender ? const Radius.circular(0) : const Radius.circular(10),
                ),
              ),
              child: Text(
                text,
                style: isSender ? TextTheme.of(context).labelLarge : TextTheme.of(context).labelLarge,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 8,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (isSender) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all, size: 12, color: Colors.blue),
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}