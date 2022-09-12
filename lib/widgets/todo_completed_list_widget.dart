
import 'package:flutter/material.dart';
import 'package:my_todo_app/provider/todo_provider.dart';
import 'package:my_todo_app/widgets/todo_widget.dart';
import 'package:provider/provider.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todosCompleted;
    return todos.isEmpty?const Center(child: Text("no completed todos", style: TextStyle(fontSize: 20),)):ListView.separated(
      itemCount: todos.length,
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoWidget(todo: todo);
      },
      separatorBuilder: (BuildContext context, int index) => Container(
        height: 10,
      ),
    );
  }
}
