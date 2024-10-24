import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});
  final String message;
  final bool isCurrentUser;
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 290),
      child: Container(
        decoration: BoxDecoration(
            color: isCurrentUser ?  Colors.orange.shade500 : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: isCurrentUser
            ? Text(
                message,
                maxLines: null,
                style: const TextStyle(color: Colors.white),
              )
            : Text(
                message,
                maxLines: null,
              ),
      ),
    );
  }
}
