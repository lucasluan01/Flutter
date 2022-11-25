import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/login_bloc.dart';
import 'package:gerente_loja/pages/home_page.dart';
import 'package:gerente_loja/widgets/input_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
          break;
        case LoginState.FAIL:
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text("Erro"),
              content: Text("Você não possui os privilégios necessários"),
            ),
          );
          break;
        case LoginState.IDLE:
        case LoginState.LOADING:
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<LoginState>(
            initialData: LoginState.LOADING,
            stream: _loginBloc.outState,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case LoginState.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  );
                case LoginState.IDLE:
                case LoginState.SUCCESS:
                case LoginState.FAIL:
                  return ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    children: <Widget>[
                      const Icon(
                        Icons.store,
                        size: 120,
                      ),
                      const SizedBox(height: 72),
                      Column(
                        children: [
                          InputFieldWidget(
                            icon: Icons.person,
                            label: "Usuário",
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
                          ),
                          const SizedBox(height: 16),
                          InputFieldWidget(
                            icon: Icons.lock,
                            label: "Senha",
                            isObscure: true,
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                          ),
                        ],
                      ),
                      const SizedBox(height: 72),
                      StreamBuilder(
                        stream: _loginBloc.outSubmitValid,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: snapshot.hasData ? _loginBloc.submit : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              disabledBackgroundColor: Colors.pink.withAlpha(100),
                            ),
                            child: const Text(
                              "Entrar",
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                default:
                  const Text("Algo de errado não está certo");
              }
              return const Text("Algo de errado não está certo");
            }),
      ),
    );
  }
}
