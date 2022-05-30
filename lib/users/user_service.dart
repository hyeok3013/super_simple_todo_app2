import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Create a new user with a first and last name

  deleteUserData(String colPath, String docPath) {
    db.collection(colPath).doc(docPath).delete();
  }
}
