import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:super_simple_todo_app/main.dart';
import 'package:super_simple_todo_app/users/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _user = "";
  @override
  void initState() {
    authLogIn();

    super.initState();
  }

  authLogIn() async {
    UserCredential result = await _auth.signInAnonymously();
    _user = result.user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      users: _user,
                      title: "SuperSimpleTodoApp",
                    ),
                  ),
                );
              },
              child: Text("START"))
        ],
      ),
    );
  }
}
