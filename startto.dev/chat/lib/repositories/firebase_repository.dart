import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseRepository {
  static Future<void> initFirebase() async {
    await Firebase.initializeApp();
  }

  static uploadFile(XFile imageFile) async {
    String url = "";

    Reference ref = FirebaseStorage.instance.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
    UploadTask task = ref.putFile(File(imageFile.path));

    await task.whenComplete(() async {
      url = await task.snapshot.ref.getDownloadURL();
    });
    return url;
  }

  static void sendMessage({
    String? message,
    XFile? imageFile,
  }) async {
    Map<String, dynamic> bodyMessage = {};

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
