import 'package:flutter/material.dart';
import 'package:my_todo_app/api/firebase_api.dart';
import 'package:my_todo_app/model/todo_model.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todos = [];

  List<TodoModel> get todos =>
      _todos.where((element) => element.isDone == false).toList();

  List<TodoModel> get todosCompleted =>
      _todos.where((element) => element.isDone == true).toList();

  void addTodo(TodoModel todo) {
    //_todos.add(todo);
    //notifyListeners();

    FirebaseApi.createTodo(todo);
    notifyListeners();
  }

  void setTodo(List<TodoModel> todos) {
    //this binding method will make sure that the setTodo is not being called
    //during the build method
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _todos = todos;
      notifyListeners();
    });
  }

  void updateTodo(TodoModel todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    FirebaseApi.updateTodo(todo);
    notifyListeners();
  }

  void removeTodo(TodoModel todo) {
    //_todos.remove(todo);

    FirebaseApi.deleteTodo(todo);
   // notifyListeners();
  }

  bool toggleIsDoneStatus(TodoModel todo) {
    todo.isDone = !todo.isDone;
    //notifyListeners();
    FirebaseApi.updateTodo(todo);


    return todo.isDone;
  }
}
