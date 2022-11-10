import 'package:chat/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.message,
  });

  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    bool isCurrentUser = auth.getCurrentUser().uid == message["senderID"];
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.indigo.shade100 : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message["senderName"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  DateFormat("HH:mm").format(DateTime.parse(message["sentIn"])),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          subtitle: message["text"] != null
              ? Text(
                  message["text"],
                  style: const TextStyle(fontSize: 16),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    message["imageUrl"],
                  ),
                ),
        ),
      ),
    );
  }
}
