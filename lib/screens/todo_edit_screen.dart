import 'package:flutter/material.dart';
import 'package:my_todo_app/model/todo_model.dart';
import 'package:my_todo_app/provider/todo_provider.dart';
import 'package:my_todo_app/widgets/todo_form_widget.dart';
import 'package:provider/provider.dart';

class TodoEditScreen extends StatefulWidget {
  const TodoEditScreen({Key? key, required this.todo}) : super(key: key);

  final TodoModel todo;

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  late String description;
  late String title;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    description = widget.todo.description;
    title = widget.todo.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {deleteTodo();}, icon: const Icon(Icons.delete))],
        title: const Text(
          'edit todo',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _key,
          child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => this.title = title,
              onChangedDescription: (description) => this.description = description,
              onSaveTodo: (){saveTodo();}),
        ),
      ),
    );
  }

  void saveTodo() {
    final isValid = _key.currentState!.validate();

    if(!isValid){
      return;
    }else{
      final provider = Provider.of<TodoProvider>(context,listen: false);
      provider.updateTodo(widget.todo,title,description);
      Navigator.of(context).pop();
    }
  }

  void deleteTodo() {
    final provider = Provider.of<TodoProvider>(context,listen: false);
    provider.removeTodo(widget.todo);
    Navigator.of(context).pop();
  }
}
