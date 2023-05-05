import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseClass {
  Future<List> GetRoute() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var data = snap.value as List;

    return data;
  }


   Future<String> getBusStopNameFromID(int busStopId,int routeIndex)async
  {
        final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var routes = snap.value as List;

       return routes[routeIndex][busStopId].toString();
       
  }



  
}
