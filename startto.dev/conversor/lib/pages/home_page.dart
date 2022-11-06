import 'package:conversor/widgets/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  late double dolar;
  late double euro;

  _realChanged(String value) {
    double real = value.isNotEmpty ? double.parse(value) : 0;
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  _dolarChanged(String value) {
    double dolar = value.isNotEmpty ? double.parse(value) : 0;
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  _euroChanged(String value) {
    double euro = value.isNotEmpty ? double.parse(value) : 0;
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  Future<Map> getData() async {
    var url = Uri.https('api.hgbrasil.com', '/finance', {'key': '3a97f6f1'});
    var response = await http.get(url);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.monetization_on,
              size: 32,
            ),
            SizedBox(
              width: 16,
            ),
            Text('Conversor de moedas'),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Carregando dados...',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Erro ao carregar dados :(',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                dolar = snapshot.data!['results']['currencies']['USD']['buy'];
                euro = snapshot.data!['results']['currencies']['EUR']['buy'];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFieldCustom(
                        controller: realController,
                        labelText: "Real",
                        prefixText: "R\$ ",
                        onChanged: _realChanged,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldCustom(
                        controller: dolarController,
                        labelText: "Dólar (US\$ $dolar)",
                        prefixText: "US\$ ",
                        onChanged: _dolarChanged,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldCustom(
                        controller: euroController,
                        labelText: "Euro (€ $euro)",
                        prefixText: "€ ",
                        onChanged: _euroChanged,
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
