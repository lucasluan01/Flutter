import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';
import 'package:xlo_mobx/screens/base_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(const MyApp());

  IbgeRepository().getUFList().then((v) {
    IbgeRepository().getCityListFromApi(v.first).then((value) => print(value));
  });
}

Future<void> initializeParse() async {
  await Parse().initialize(
    'zG6gDtjfDAOVxq7fMMbbbRbaiGXHOcFCtlgezUPk',
    'https://parseapi.back4app.com/',
    clientKey: 'aIdE26qyxvylgGEshSR9Z6IHsjCCIWAUGzK7RTx7',
    autoSendSessionId: true,
    debug: true,
  );
}

void setupLocators() {
  GetIt.I.registerSingleton<PageStore>(PageStore());
  GetIt.I.registerSingleton<UserManagerStore>(UserManagerStore());
  GetIt.I.registerSingleton<CategoryStore>(CategoryStore());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XLO',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(elevation: 0),
        scaffoldBackgroundColor: Colors.purple,
        indicatorColor: Theme.of(context).primaryColor,
      ),
      home: const BaseScreen(),
    );
  }
}
