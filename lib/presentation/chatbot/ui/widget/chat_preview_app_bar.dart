import 'package:flutter/material.dart';
import '../../../../core/theme/color.dart';


class ChatPreviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatPreviewAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72.75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Theme.of(context).cardColor,
      backgroundColor: Theme.of(context).cardColor,
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      toolbarHeight: preferredSize.height,
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