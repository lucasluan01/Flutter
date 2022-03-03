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
  Map<String, dynamic> _ultimaTarefaRemovida = {};
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  Future<File> _getArquivo() async {
    final diretorio = await getApplicationDocumentsDirectory();
    File arquivo = File("${diretorio.path}/tarefas.json");

    if (!await arquivo.exists()) {
      return arquivo.create();
    }
    return arquivo;
  }

  _salvarArquivo() async {
    final arquivo = await _getArquivo();
    arquivo.writeAsString(json.encode(_listaTarefas));
  }

  _salvarTarefa() {
    Map<String, dynamic> tarefa = {};
    tarefa["titulo"] = _tituloController.text.isNotEmpty
        ? _tituloController.text
        : "Sem título";
    tarefa["descricao"] = _descricaoController.text.isNotEmpty
        ? _descricaoController.text
        : "Sem descrição";
    tarefa["status"] = false;

    setState(() {
      _listaTarefas.add(tarefa);
    });

    _descricaoController.text = "";
    _tituloController.text = "";
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
        if (tarefas.toString().isNotEmpty) {
          _listaTarefas = json.decode(tarefas);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                return Card(
                  child: Dismissible(
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direcao) {
                      _ultimaTarefaRemovida = _listaTarefas[index];
                      setState(() {
                        _listaTarefas.removeAt(index);
                        _salvarArquivo();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Tarefa removida."),
                          action: SnackBarAction(
                            label: "Desfazer",
                            onPressed: () {
                              setState(() {
                                _listaTarefas.insert(
                                    index, _ultimaTarefaRemovida);
                                _salvarArquivo();
                              });
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "Remover",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    child: CheckboxListTile(
                      title: Text(_listaTarefas[index]["titulo"]),
                      subtitle: Text(_listaTarefas[index]["descricao"]),
                      value: _listaTarefas[index]["status"],
                      onChanged: (isStatus) {
                        setState(() {
                          _listaTarefas[index]["status"] = isStatus;
                          _salvarArquivo();
                        });
                      },
                    ),
                  ),
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
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _tituloController,
                      decoration: const InputDecoration(
                        labelText: "Título:",
                      ),
                    ),
                    TextField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(
                        labelText: "Descrição:",
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _descricaoController.text = "";
                      _tituloController.text = "";
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    // style: ,
                    onPressed: () {
                      if (_tituloController.text.isNotEmpty ||
                          _descricaoController.text.isNotEmpty) {
                        _salvarTarefa();
                        Navigator.pop(context);
                      }
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
