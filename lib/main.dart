import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:super_simple_todo_app/pages/input_page.dart';
import 'package:super_simple_todo_app/pages/splash_page.dart';
import 'package:super_simple_todo_app/pages/update_page.dart';
import 'package:super_simple_todo_app/users/user_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Super Simple Todo App", home: SplashPage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, required this.users})
      : super(key: key);
  final String title;
  final String users;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    userPath: widget.users,
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection(widget.users).snapshots(),
          builder: (context, snapshot) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      UserService().deleteUserData(
                          widget.users, snapshot.data!.docs[index].id);
                    },
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdatePage(
                            path: snapshot.data!.docs[index].id,
                            userPath: widget.users,
                          ),
                        ),
                      );
                    },
                    title: Text(snapshot.data!.docs[index]['first'].toString()),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
                    color: Colors.black,
                  );
                },
                itemCount: snapshot.data?.docs.length ?? 0);
          }),
    );
  }
}
