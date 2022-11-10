import 'package:chat/auth/auth_service.dart';
import 'package:chat/repositories/firebase_repository.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:chat/widgets/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("${auth.getCurrentUser().displayName}"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              size: 28,
            ),
            onPressed: () async {
              AuthService service = AuthService();
              await service.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseRepository.getMessages(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  default:
                    List<DocumentSnapshot> docs = snapshot.data!.docs.toList();
                    docs.sort((a, b) => b["sentIn"].compareTo(a["sentIn"]));
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(16),
                      itemCount: docs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> message = docs[index].data()! as Map<String, dynamic>;
                        return ChatMessage(message: message);
                      },
                    );
                }
              },
            ),
          ),
          const TextComposer(sendMessage: FirebaseRepository.sendMessage),
        ],
      ),
    );
  }
}
