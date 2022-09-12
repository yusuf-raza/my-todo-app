import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo_app/model/todo_model.dart';
import 'package:my_todo_app/provider/todo_provider.dart';
import 'package:my_todo_app/screens/todo_edit_screen.dart';
import 'package:my_todo_app/utils/utils.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Slidable(
        key: ValueKey(todo.id),
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (_) => deleteTodo(context, todo),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete',
            ),
            SlidableAction(
              onPressed: (_) => editTodo(context, todo),
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'edit',
            ),
          ],
        ),
        child: buildTodo(context),
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          Checkbox(
              value: todo.isDone,
              checkColor: Colors.white,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (_) {
                final provider =
                    Provider.of<TodoProvider>(context, listen: false);
                final isDone = provider.toggleIsDoneStatus(todo);
                Utils.showSnackbar(
                    context, isDone ? "task completed!" : "task incomplete!");
              }),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.title,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              if (todo.description.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    todo.description,
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  deleteTodo(BuildContext context, TodoModel todo) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    provider.removeTodo(todo);
    // ,notifyListeners();

    Utils.showSnackbar(context, "task deleted!");
  }

  editTodo(BuildContext context, TodoModel todo) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => TodoEditScreen(todo: todo)));
  }
}
