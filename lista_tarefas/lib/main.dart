import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lista de Tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _listaTarefas = [];
  final TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getArquivo() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/tarefas.json");
  }

  _salvarArquivo() async {
    final arquivo = await _getArquivo();
    arquivo.writeAsString(json.encode(_listaTarefas));
  }

  _salvarTarefa() {
    Map<String, dynamic> tarefa = {};
    tarefa["titulo"] = _controllerTarefa.text;
    tarefa["status"] = false;

    setState(() {
      _listaTarefas.add(tarefa);
    });

    _controllerTarefa.text = "";
    _salvarArquivo();
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getArquivo();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _lerArquivo().then((tarefas) {
      setState(() {
        _listaTarefas = json.decode(tarefas);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // _salvarArquivo();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _listaTarefas.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_listaTarefas[index]["titulo"]),
                  value: _listaTarefas[index]["status"],
                  onChanged: (isStatus) {
                    setState(() {
                      _listaTarefas[index]["status"] = isStatus;
                    });
                    _salvarArquivo();
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Adicionar tarefa"),
                content: TextField(
                  controller: _controllerTarefa,
                  decoration: const InputDecoration(
                    labelText: "Informe a nova tarefa",
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () {
                      _salvarTarefa();
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
