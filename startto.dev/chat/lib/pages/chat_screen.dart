import 'package:chat/repositories/firebase_repository.dart';
import 'package:chat/widgets/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nome do destinatário"),
        centerTitle: true,
        elevation: 0,
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
                      return const CircularProgressIndicator();
                    default:
                      List<DocumentSnapshot> docs = snapshot.data!.docs.reversed.toList();

                      return ListView.builder(
                        itemCount: docs.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              docs[index].get('text'),
                            ),
                          );
                        },
                      );
                  }
                }),
          ),
          const TextComposer(sendMessage: FirebaseRepository.sendMessage),
        ],
      ),
    );
  }
}
