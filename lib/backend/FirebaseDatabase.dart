import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseClass {
  Future<List> GetRoute() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var data = snap.value as List;

    return data;
  }

   Future<List<dynamic>> getBusStopNameFromID()async
  {
        final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var routes = snap.value as List;

       return routes;
       
  }

  Future<Map> gerRouteIdAndBusStops(String StartStop ,String DestinationStop)async
  { 
    
    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    List<List<String>> myRoot=[] ;
    var routes = snap.value as List;
    var routeIndex=0;
    int numberOfAvailableRoutes=0;
         routes.asMap().forEach((index, route) {
      if (route.contains(StartStop) && route.contains(DestinationStop)) {
        print("SAdafasfasf");
        routeIndex = index;
       
        int currentstopIndex = route.indexOf(StartStop);
        int destinationStopIndex = route.indexOf(DestinationStop);
         print("curr="+currentstopIndex.toString()+"des="+destinationStopIndex.toString());
       
        myRoot.add([]);
        for (int i = currentstopIndex; i <= destinationStopIndex; i++) {
          myRoot[numberOfAvailableRoutes].add(routes[routeIndex][i]);
        }

        numberOfAvailableRoutes++;
      }
    });

      print(myRoot);

    return {"routeIndex":routeIndex,"busStops":myRoot};
  }



  
  
}
