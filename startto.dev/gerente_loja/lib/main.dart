import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade900,
        primarySwatch: Colors.pink,
        iconTheme: const IconThemeData(color: Colors.pink),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: const LoginPage(),
    );
  }
}
