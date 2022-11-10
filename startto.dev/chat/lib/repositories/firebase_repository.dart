import 'dart:io';
import 'package:chat/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseRepository {
  static uploadFile(XFile imageFile) async {
    String url = "";
    AuthService auth = AuthService();
    Reference ref = FirebaseStorage.instance.ref().child(
          auth.getCurrentUser().uid + DateTime.now().millisecondsSinceEpoch.toString(),
        );
    UploadTask task = ref.putFile(File(imageFile.path));

    await task.whenComplete(() async {
      url = await task.snapshot.ref.getDownloadURL();
    });
    return url;
  }

  static sendMessage({
    String? message,
    XFile? imageFile,
  }) async {
    AuthService auth = AuthService();
    User user = auth.getCurrentUser();

    Map<String, dynamic> bodyMessage = {
      "senderID": user.uid,
      "senderName": user.displayName,
      "sentIn": DateTime.now().toString(),
    };

    if (message != null) {
      bodyMessage["text"] = message;
    }

    if (imageFile != null) {
      bodyMessage["imageUrl"] = await uploadFile(imageFile);
    }
    FirebaseFirestore.instance.collection("messages").add(bodyMessage);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    return FirebaseFirestore.instance.collection("messages").snapshots();
  }
}
