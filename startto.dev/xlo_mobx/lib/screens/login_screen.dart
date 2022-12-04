import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/signup_screen.dart';
import 'package:xlo_mobx/stores/login_store.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginStore loginStore = LoginStore();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(32),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Observer(
                  builder: (_) {
                    if (loginStore.error != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(loginStore.error!),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Acessar com e-mail:",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        TextField(
                          enabled: !loginStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.emailError,
                            suffixIcon: loginStore.emailError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: loginStore.setEmail,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          enabled: !loginStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.passwordError,
                            suffixIcon: loginStore.passwordError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          obscureText: true,
                          onChanged: loginStore.setPassword,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Esqueci minha senha",
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: loginStore.loginPressed,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.25),
                              disabledForegroundColor: Colors.white,
                            ),
                            child: loginStore.isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text("ENTRAR"),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Expanded(child: Divider(thickness: 1)),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: const Text(
                                "ou",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            const Expanded(child: Divider(thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text("Entrar com o Facebook"),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Não tem uma conta?",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignupScreen()));
                                  },
                                  child: Text(
                                    "Cadastre-se",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
