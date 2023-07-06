import 'dart:ffi';

import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseDatabaseClass {
  //To get all the routes from database
  Future<List<dynamic>> getRoutes() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var routes = snap.value as List;

    return routes;
  }

  Future<Map> gerRouteIdAndBusStops(
      String StartStop, String DestinationStop) async {
    var routes = await getRoutes();
    List<List<String>> myRoot = [];

    
print( StartStop+" :"+DestinationStop);

    var routeIndex = 0;
    int numberOfAvailableRoutes = 0;
    routes.asMap().forEach((index, route) {
      print(route);
      if ((route as List).contains(StartStop) &&
          route.contains(DestinationStop)) {
        routeIndex = index;

        int currentstopIndex = route.indexOf(StartStop);
        int destinationStopIndex = route.indexOf(DestinationStop);
        print("curr=" +
            currentstopIndex.toString() +
            "des=" +
            destinationStopIndex.toString());

        myRoot.add([]);
        for (int i = currentstopIndex; i <= destinationStopIndex; i++) {
          myRoot[numberOfAvailableRoutes].add(routes[routeIndex][i]);
        }

        numberOfAvailableRoutes++;
      }
    });
    print("llllllllllllllllll");
    print(myRoot);
     if(myRoot.isEmpty)
    {
      print("ssssssssssssssss");
        Fluttertoast.showToast(msg: "No Buses in this route availabale");
    }

    return {"routeIndex": routeIndex, "busStops": myRoot};
  }

  Future<List> getRouteBusStops(int routeindex) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    List<String> myRoot = [];
    var routes = snap.value as List;
    var routeIndex = 0;
    int numberOfAvailableRoutes = 0;

    routes[routeindex].forEach((element) {
      myRoot.add(element);
    });
    print(myRoot);

    return myRoot;
  }

  Future<int> getRootDirection(
      String startStop, String endStop, int rootId) async {
    var data = await getRoutes();

    print(
        "***************************** Finding root Direction***************************************");

    var route = data[rootId] as List;
    int startStopindex = 0;
    int endStopindex = 0;
    for (int i = 0; i < route.length; i++) {
      if (route[i] == startStop) {
        startStopindex = i;
      }
      if (route[i] == endStop) {
        endStopindex = i;
      }
    }

    if (startStopindex < endStopindex) {
      print("Route Direction is forward");
      print(
          "*********************************************************************************");
      return 0;
    } else {
      print("Route Direction is backward");
      print(
          "*********************************************************************************");
      return 1;
    }
  }





  //ALGORITHM

  //Assuming  the distance table  is structured in a way that  all bustopsid contains id of all nearest
  //busstops which gives distance between them 
  //so while finding the distance  we take all the id of the  respcetive bustops in the route
  //then we take first id and look into the  distance reference table;
  // so the next id(after fist id) that is next bus stop in the route must be inside the previous busid as  those two bustops are near(In distance reference)
  // so this is happening  not according to any sequence bus the  nearest bustop

  //works on the concept that nearest bustops are linked with id....
  // so we can retrive the distance between them using those id as i and j in two dimension list

  Future<int> getDistanceBwtTwoBusStop(String startt, String busLocation,
      int routeindex, int routeDirection) async {
    print(
        "\n\n********************Getting Distance between two bustop ${startt} and ${busLocation} *************************\n\n");

    var routeIdList = [];

    var startId = 0;
    var busLocationId = 0;

    var routes = await getRouteBusStops(routeindex);

    for (int i = 0; i < routes.length; i++) {
      var id = await SupaBaseDatabase().getbusStopIdusingName(routes[i]);
      if (startt == routes[i]) {
        startId = id;
        print("Id of BusStop 1:" + startId.toString());
      }
      if (busLocation == routes[i]) {
        busLocationId = id;
        print("Id of Bus Stop 2:" + busLocationId.toString());
      }

      routeIdList.add(id);
    }

    print("Route Id List: " + routeIdList.toString());

    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Distances').get();
    List<List<int>> distances = [];
    var dist = snap.value as List;

    var d = 0;

    if (routeDirection == 0) {
      for (int j = busLocationId; j <startId; j++) {
        print("Distance beween ${j} and ${j + 1}: ${dist[routeIdList[j]]["${routeIdList[j + 1]}"] as int}");

        d = d + dist[routeIdList[j] - 1]["${routeIdList[j + 1] - 1}"] as int;
      }
    } else {
      for (int j = startId; j <busLocationId; j++) {
        print("Distance beween ${j} and ${j + 1}: ${dist[routeIdList[j]]["${routeIdList[j + 1]}"] as int}");

        d = d + dist[routeIdList[j] - 1]["${routeIdList[j + 1] - 1}"] as int;
      }
    }
   

    print("Total distance=" + d.toString());
    print(
        "******************************************************************************");
    return d;
  }
}
