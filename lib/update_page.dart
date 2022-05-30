import 'package:flutter/material.dart';
import 'package:super_simple_todo_app/users/user_service.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({Key? key, required this.path}) : super(key: key);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();
  String? title;
  String? subtitle;
  String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("입력하기"),
        actions: [
          IconButton(
              onPressed: () {
                UserService()
                    .db
                    .collection("users")
                    .doc(path)
                    .update({"first": title, "last": subtitle});
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _titleController,
            onChanged: (_) {
              title = _titleController.text;
            },
          ),
          TextFormField(
            controller: _subtitleController,
            onChanged: (_) {
              subtitle = _subtitleController.text;
            },
          ),
        ],
      ),
    );
  }
}
