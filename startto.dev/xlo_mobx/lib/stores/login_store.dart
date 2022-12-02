import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'login_store.g.dart';

// ignore: library_private_types_in_public_api
class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @action
  Future<void> _login() async {
    isLoading = true;

    try {
      final resultUser = await UserRepository().loginWithEmail(email!, password!);
      GetIt.I<UserManagerStore>().setUser(resultUser);
    } catch (e) {
      error = e as String;
    } finally {
      isLoading = false;
    }
  }

  @computed
  bool get emailValid => email != null && email!.isEmailValid();

  @computed
  bool get passwordValid => password != null && password!.length >= 8;

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
  bool get isFormValid => emailValid && passwordValid;

  @computed
  get loginPressed => isFormValid && !isLoading ? _login : null;
}
