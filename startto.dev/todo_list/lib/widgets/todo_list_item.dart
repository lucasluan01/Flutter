import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/todo.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onChecked,
  });

  final Todo todo;
  final Function(Todo) onDelete;
  final Function(Todo) onChecked;

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            widget.onDelete(widget.todo);
          }),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                widget.onDelete(widget.todo);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: CheckboxListTile(
          value: widget.todo.done,
          tileColor: Colors.grey.shade200.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          title: Text(
            DateFormat('dd/MM/yyyy HH:mm:ss').format(widget.todo.creationDate),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          subtitle: Text(
            widget.todo.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          secondary: const SizedBox(
            height: double.infinity,
            child: Icon(Icons.drag_handle),
          ),
          onChanged: (value) {
            setState(() {
              widget.onChecked(widget.todo);
            });
          },
        ),
      ),
    );
  }
}
