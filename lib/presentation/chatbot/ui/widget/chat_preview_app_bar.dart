import 'package:flutter/material.dart';
import '../../../../core/theme/color.dart';


class ChatPreviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatPreviewAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72.75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      shadowColor: Theme.of(context).shadowColor,
      elevation: 2,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.android, size: 24, color: Colors.black54),
            ),
            const SizedBox(width: 7.44),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chatbot', style: TextTheme.of(context).headlineMedium),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const ShapeDecoration(
                        color: onlineColor,
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text('Online', style: TextTheme.of(context).bodySmall),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}