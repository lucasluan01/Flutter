import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController taskController = TextEditingController();
  final TodoRepository _todoRepository = TodoRepository();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  void initState() {
    super.initState();

    _todoRepository.getTodoList().then(
          (value) => setState(
            () {
              todos = value;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Card(
                elevation: 2,
                shadowColor: Colors.black38,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: taskController,
                            decoration: const InputDecoration(
                              hintText: 'Adicione uma tarefa',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              todos.add(
                                Todo(
                                  title: taskController.text,
                                  creationDate: DateTime.now(),
                                ),
                              );
                            });
                            taskController.clear();
                            _todoRepository.saveTodoList(todos);
                          },
                          style: ElevatedButton.styleFrom(),
                          child: const Icon(
                            Icons.add,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return TodoListItem(
                      todo: todos[index],
                      onDelete: onDelete,
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas pendentes',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                      ),
                      child: const Text('Limpar tudo'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    _todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa ${todo.title} foi removida com sucesso!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
            _todoRepository.saveTodoList(todos);
          },
        ),
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.none,
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar todas as tarefas'),
        content: const Text(
          'Você tem certeza que deseja apagar todas as tarefas?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                todos.clear();
              });
              _todoRepository.saveTodoList(todos);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Apagar tudo'),
          ),
        ],
      ),
    );
  }
}
