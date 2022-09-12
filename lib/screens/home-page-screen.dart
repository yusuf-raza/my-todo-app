import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/api/firebase_api.dart';
import 'package:my_todo_app/main.dart';
import 'package:my_todo_app/model/todo_model.dart';
import 'package:my_todo_app/provider/todo_provider.dart';
import 'package:my_todo_app/widgets/todo_completed_list_widget.dart';
import 'package:my_todo_app/widgets/todo_dialog_widget.dart';
import 'package:my_todo_app/widgets/todo_list_widget.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  //index for bottom navigation item track
  //with 0 being the default tab
  int selectedIndex = 0;

  TodoProvider providerObj = TodoProvider();

  @override
  Widget build(BuildContext context) {
    //these tabs will layout the page based on options selected from bottom navigation bar
    final tabs = [const TodoListWidget(), const CompletedListWidget()];
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      body: StreamBuilder<List<TodoModel>>(
          stream: FirebaseApi.readTodo(),
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
            switch (snapshot.connectionState) {
              //case ConnectionState.waiting:
                //return const Center(child: CircularProgressIndicator());

              default:
                if (snapshot.hasError) {
                  return const Center(child: Text("try again later"));
                } else {
                  final todos = snapshot.data;

                  var result = todos;

                  if (result != null) {
                    final provider = Provider.of<TodoProvider>(context);

                    provider.setTodo(todos!);
                    //print("");
                    return tabs[selectedIndex];
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.pink,
          unselectedItemColor: Colors.white.withOpacity(.7),
          selectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          //onTap will switch between bottom navigation items
          onTap: (index) => setState(() {
                selectedIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
                label: 'todos', icon: Icon(Icons.fact_check_outlined)),
            BottomNavigationBarItem(label: 'completed', icon: Icon(Icons.done))
          ]),
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () => showDialog(
                context: context,
                builder: (_) => const TodoDialogWidget(),
              ),
          backgroundColor: Colors.black,
          child: const Icon(Icons.add)),
    );
  }
}
