import 'dart:async';

class LoginValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@")) {
      sink.add(email);
      return;
    }
    sink.addError("E-mail inválido");
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password);
      return;
    }
    sink.addError("A senha deve conter pelo menos 8 caracteres");
  });
}
