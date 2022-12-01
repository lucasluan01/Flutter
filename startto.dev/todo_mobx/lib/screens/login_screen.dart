import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/stores/login_store.dart';
import 'package:todo_mobx/widgets/custom_icon_button.dart';
import 'package:todo_mobx/widgets/custom_text_field.dart';
import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginStore loginStore;
  late ReactionDisposer _reactionDisposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginStore = Provider.of<LoginStore>(context);

    _reactionDisposer = autorun((_) {
      if (loginStore.loggedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ListScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _reactionDisposer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Observer(
                    builder: (_) {
                      return CustomTextField(
                        hint: 'E-mail',
                        prefix: const Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                        enabled: !loginStore.isLoading,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(builder: (_) {
                    return CustomTextField(
                      hint: 'Senha',
                      prefix: const Icon(Icons.lock),
                      obscure: !loginStore.isShowPassword,
                      onChanged: loginStore.setPassword,
                      enabled: !loginStore.isLoading,
                      suffix: CustomIconButton(
                        radius: 32,
                        iconData: !loginStore.isShowPassword ? Icons.visibility : Icons.visibility_off,
                        onTap: loginStore.togglePassword,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: Observer(
                      builder: (_) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                            disabledBackgroundColor: Theme.of(context).primaryColor.withAlpha(100),
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: loginStore.loginPressed,
                          child: loginStore.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Login'),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
