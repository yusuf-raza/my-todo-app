import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  const TodoFormWidget(
      {Key? key,
      this.title = "",
      this.description = "",
      required this.onChangedTitle,
      required this.onChangedDescription,
      required this.onSaveTodo})
      : super(key: key);

  final String title;
  final String description;

  //call back functions for title and description
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  //void call back function to save todo
  final VoidCallback onSaveTodo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 15,),
          buildSaveButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      initialValue: title,
      onChanged: onChangedTitle,
      validator: (title) {
        if (title!.isEmpty) {
          return "title cannot be empty!";
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(label: Text('title')),
    );
  }

  Widget buildDescription() => TextFormField(
        initialValue: description,
        onChanged: onChangedDescription,
        maxLines: 3,
       /* validator: (description) {
          if (description!.isEmpty) {
            return "description cannot be empty!";
          } else {
            return null;
          }
        },*/
        decoration: const InputDecoration(label: Text('description')),
      );

  Widget buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: onSaveTodo,
        child: const Text('save'),
      ),
    );
  }
}
