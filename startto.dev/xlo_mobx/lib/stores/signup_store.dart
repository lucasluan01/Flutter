import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

part 'signup_store.g.dart';

// ignore: library_private_types_in_public_api
class SignupStore = _SignupStoreBase with _$SignupStore;

abstract class _SignupStoreBase with Store {
  @observable
  String? name;

  @observable
  String? email;

  @observable
  String? phone;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  void setName(String value) => name = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPhone(String value) => phone = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setConfirmPassword(String value) => confirmPassword = value;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @action
  Future<void> _signup() async {
    isLoading = true;

    final user = User(name: name!, email: email!, phone: phone!, password: password!);

    try {
      final resultUser = await UserRepository().signUp(user);
      print(resultUser);
    } catch (e) {
      error = e as String;
    }
    finally {
      isLoading = false;
    }
  }

  @computed
  bool get nameValid => name != null && name!.length >= 4;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();

  @computed
  bool get phoneValid => phone != null && phone!.length == 16;

  @computed
  bool get passwordValid => password != null && password!.length >= 8;

  @computed
  bool get confirmPasswordValid => confirmPassword != null && confirmPassword == password;

  @computed
  String? get nameError {
    if (name == null) {
      return null;
    }

    if (name!.isEmpty) {
      return "Campo obrigatório";
    }

    if (name!.length < 4) {
      return "O apelido dever conter pelo menos 4 caracteres";
    }
    return null;
  }

  @computed
  String? get emailError {
    if (email == null) {
      return null;
    }

    if (email!.isEmpty) {
      return "Campo obrigatório";
    }

    if (!email!.isEmailValid()) {
      return "E-mail inválido";
    }
    return null;
  }

  @computed
  String? get phoneError {
    if (phone == null) {
      return null;
    }

    if (phone!.isEmpty) {
      return "Campo obrigatório";
    }

    if (phone!.length < 16) {
      return "Celular inválido";
    }
    return null;
  }

  @computed
  String? get passwordError {
    if (password == null) {
      return null;
    }

    if (password!.isEmpty) {
      return "Campo obrigatório";
    }

    if (password!.length < 8) {
      return "A senha deve conter pelo menos 8 caracteres";
    }
    return null;
  }

  @computed
  String? get confirmPasswordError {
    if (confirmPassword == null) {
      return null;
    }

    if (confirmPassword!.isEmpty) {
      return "Campo obrigatório";
    }

    if (confirmPassword != password) {
      return "As senhas não coincidem";
    }
    return null;
  }

  @computed
  bool get isFormValid => [
        nameValid,
        emailValid,
        phoneValid,
        passwordValid,
        confirmPasswordValid,
      ].every((element) => element == true);

  @computed
  get signupPressed => isFormValid && !isLoading ? _signup : null;
}
