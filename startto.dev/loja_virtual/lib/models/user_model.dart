import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  Map<String, dynamic> userData = {};

  static UserModel of(BuildContext context) {
    return ScopedModel.of<UserModel>(context);
  }

  @override
  void addListener(VoidCallback listener) async {
    super.addListener(listener);
    await loadCurrentUser();
  }

  void signIn({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    isLoading = false;
    notifyListeners();

    auth.signInWithEmailAndPassword(email: email, password: password).then((user) async {
      this.user = user.user;

      await loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  signUp({
    required Map<String, dynamic> userData,
    required String pass,
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    isLoading = true;
    notifyListeners();

    auth.createUserWithEmailAndPassword(email: userData["email"], password: pass).then((user) async {
      this.user = user.user;

      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPass(String email) {
    auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return user != null;
  }

  void signOut() async {
    await auth.signOut();
    userData = {};
    user = null;
    notifyListeners();
  }

  Future<void> loadCurrentUser() async {
    if (user == null) {
      user = auth.currentUser;
      return;
    }

    if (userData["name"] == null) {
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
      userData = docUser.data()!;
    }
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set(userData);
  }
}
