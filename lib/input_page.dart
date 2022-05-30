import 'package:flutter/material.dart';
import 'package:super_simple_todo_app/users/user_service.dart';

class InputPage extends StatelessWidget {
  InputPage({Key? key}) : super(key: key);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();
  String? title;
  String? subtitle;

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
                    .add({"first": title, "last": subtitle});
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
