import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseClass {
  Future<List> GetRoute() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var data = snap.value as List;

    return data;
  }


  
}
