import 'package:flutter/material.dart';
import 'package:my_todo_app/model/todo_model.dart';
import 'package:my_todo_app/provider/todo_provider.dart';
import 'package:my_todo_app/widgets/todo_form_widget.dart';
import 'package:provider/provider.dart';

class TodoDialogWidget extends StatefulWidget {
  const TodoDialogWidget({Key? key}) : super(key: key);

  @override
  State<TodoDialogWidget> createState() => _TodoDialogWidgetState();
}

class _TodoDialogWidgetState extends State<TodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'add todo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSaveTodo: addTodo)
          ],
        ),
      ),
    );
  }

  void addTodo() {
    //to validate the fields of form using global form key
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      TodoModel todo = TodoModel(
          id: DateTime.now().toString(),
          title: title,
          description: description,
          createdTime: DateTime.now());
      final provider = Provider.of<TodoProvider>(context,listen: false);
      provider.addTodo(todo);

      Navigator.pop(context);
    }
  }
}
