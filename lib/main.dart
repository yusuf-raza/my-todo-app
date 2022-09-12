import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/provider/todo_provider.dart';
import 'package:my_todo_app/screens/home-page-screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title ='my todo app';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>TodoProvider(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
            primarySwatch: Colors.pink,
            scaffoldBackgroundColor: const Color(0xFFf6f5ee)),
        home: const HomePageScreen(),
      ),
    );
  }
}
