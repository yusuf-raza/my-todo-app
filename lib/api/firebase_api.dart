import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_todo_app/model/todo_model.dart';
import 'package:my_todo_app/utils/utils.dart';

class FirebaseApi {
  //method to create a todo document in firebase
  static Future<String> createTodo(TodoModel todo) async {
    //creating instance of firestore document
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();
    //setting todo id with the id created by firestore document
    todo.id = docTodo.id;

    //creating a todo in firestore
    //as firebase firestore on stores data in the form of json
    //so it cant recognize our todo object,
    //so we have to transform it into json first
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<TodoModel>> readTodo() => FirebaseFirestore.instance
      .collection("todo")
      .orderBy(TodoField.createdTime, descending: false)
      .snapshots()
      .transform(Utils.transformer(TodoModel.fromJson));


  static Future updateTodo(TodoModel todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(TodoModel todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}
