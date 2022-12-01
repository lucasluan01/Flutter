import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    autorun((_) {});
  }

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool isShowPassword = false;

  @observable
  bool isLoading = false;

  @observable
  bool loggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void togglePassword() => isShowPassword = !isShowPassword;

  @action
  Future<void> login() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 4));
    isLoading = false;
    loggedIn = true;
  }

  @action
  void logOut() {
    email = "";
    password = "";
    loggedIn = false;
  }

  @computed
  bool get isEmailValid => RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);

  @computed
  bool get isPasswordValid => password.length > 6;

  @computed
  get loginPressed => (isEmailValid && isPasswordValid && !isLoading) ? login : null;
}