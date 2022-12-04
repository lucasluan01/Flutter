import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupStore signupStore = SignupStore();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar conta"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(32),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Observer(
                  builder: (_) {
                    if (signupStore.error != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(signupStore.error!),
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
                        TextField(
                          enabled: !signupStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "Apelido",
                            hintText: "Exemplo: Lucas L.",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.nameError,
                            suffixIcon: signupStore.nameError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          onChanged: signupStore.setName,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          enabled: !signupStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            hintText: "exemplo@gmail.com",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.emailError,
                            suffixIcon: signupStore.emailError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: signupStore.setEmail,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          enabled: !signupStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "Celular",
                            hintText: "(31) 9 9999-9999",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.phoneError,
                            suffixIcon: signupStore.phoneError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          inputFormatters: [
                            MaskedInputFormatter('(##) # ####-####'),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          onChanged: signupStore.setPhone,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          enabled: !signupStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.passwordError,
                            suffixIcon: signupStore.passwordError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          obscureText: true,
                          onChanged: signupStore.setPassword,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          enabled: !signupStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "Confirmar senha",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.confirmPasswordError,
                            suffixIcon: signupStore.confirmPasswordError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          obscureText: true,
                          onChanged: signupStore.setConfirmPassword,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: signupStore.signupPressed,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.25),
                              disabledForegroundColor: Colors.white,
                            ),
                            child: signupStore.isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text("CADASTRAR"),
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Já tem uma conta?",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Entrar",
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
