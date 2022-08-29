import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:responsividade_flutter/pages/home/home_page.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (_) => const MyApp(),
      // enabled: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsividade Flutter 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      home: const HomePage(),
    );
  }
}