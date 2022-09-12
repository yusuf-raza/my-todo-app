import 'package:my_todo_app/utils/utils.dart';

class TodoField {
  static const String createdTime = "createdTime";
}

class TodoModel {
  DateTime? createdTime;
  String title;
  String description;
  String id;
  bool isDone;

  TodoModel(
      {required this.createdTime,
      required this.title,
      this.description = "",
      this.id = "",
      this.isDone = false});

  //method to converting received firebase doc into Todo obj
  static TodoModel fromJson(Map<String, dynamic> json)  {
    return TodoModel(
      createdTime: Utils.toDateTime(json["createdTime"]),
      title:  json["title"],
      description: json["description"],
      id: json["id"],
      isDone: json["isDone"]
    );
  }

  //method to convert the Todo obj into json for firebase
  Map<String, dynamic> toJson() {
    return {
      "createdTime": Utils.fromDateTimeToJson(createdTime!),
      "title": title,
      "description": description,
      "id": id,
      "isDone": isDone
    };
  }
}
