// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  LoginBloc() {
    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        if (await verifyPrivileges(user)) {
          _stateController.add(LoginState.SUCCESS);
          return;
        }
        FirebaseAuth.instance.signOut();
        _stateController.add(LoginState.FAIL);
        return;
      }
      _stateController.add(LoginState.IDLE);
    });
  }

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState => _stateController.stream;
  late StreamSubscription _streamSubscription;

  Stream<bool> get outSubmitValid => Rx.combineLatest2(
        outEmail,
        outPassword,
        ((a, b) => true),
      );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void submit() {
    final email = _emailController.value.trim();
    final password = _passwordController.value.trim();

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {}).catchError((e) {
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<bool> verifyPrivileges(User user) async {
    return await FirebaseFirestore.instance.collection("admins").doc(user.uid).get().then((doc) {
      return doc.data() != null;
    }).catchError((e) {
      return false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _streamSubscription.cancel();
  }
}
