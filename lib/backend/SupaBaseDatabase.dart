import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/Models/UserModel.dart';
import 'package:bustracker/backend/FirebaseDatabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Models/MyRouteModel.dart';

class SupaBaseDatabase {
  final supabase = Supabase.instance.client;

  void AddUserDetails(UserModel model) async {
    await supabase.from("Users").insert({
      "userName": model.userName,
      "userAdress": model.userAddress,
      "userPhone": model.userPhone,
      "userEmail": model.userEmail,
      "userDob": model.userDob
    });
  }

  Future<List<BusModel>> GetBusData(
      int routeId, int currentBusStopOfUser) async {
    final data = await supabase
        .from('Buses')
        .select()
        .eq("busRoute", routeId)
        .gt("busCurrentLocation", currentBusStopOfUser);

    var list = data as List;

    List<BusModel> buslist = [];

    BusModel? model;
    var routes = await FirebaseDatabaseClass().getBusStopNameFromID();

    list.forEach((element) async {
      var busStopName =
          routes[routeId][element['busCurrentLocation']].toString();

      model = BusModel(
          element['busId'],
          element['busName'],
          element['busRoute'],
          element['busNumber'],
          busStopName,
          element['startStop'],
          element['endStop'],
          element['startingTime']);

      buslist.add(model!);
    });

    return buslist;
  }

  Future<int> GetUserStopNameUsingid(String email) async {
    List data = await supabase
        .from("BusStops")
        .select("busStopName")
        .eq("userEmail", email) as List;
    print("userId=" + data[0]['userId'].toString());

    return data[0]['userId'] as int;
  }

  Future<int> getCurrentUserId() async {
    var email = Supabase.instance.client.auth.currentUser!.email;
    List data = await supabase
        .from("Users")
        .select("userId")
        .eq("userEmail", email) as List;
    print("userId=" + data[0]['userId'].toString());

    return data[0]['userId'] as int;
  }

  void Addpayement(
      int userId, int busId, int fare, String from, String to) async {
    print("userid is " + from);
    var result = await supabase.from("Payment").insert({
      "userId": userId,
      "busId": busId,
      "fromBusStop": from,
      "date": "fasf",
      "toBusStop": to,
      "busFare": fare
    });
    print(result.toString());
  }

  Future<List<MyRouteModel>> getMyroutes() async {

    var userId = await getCurrentUserId();

    List<MyRouteModel> routelist = [];
    var result =
        await supabase.from('MyRoutes').select().eq('userId', userId) as List;

    var model = MyRouteModel(1, 2, 2, " ", " ");

    result.forEach((element) {
      print(element['sartingStopName']);
      model = MyRouteModel(
          element['myRouteId'],
          element['userId'],
          element['routeId'],
          element['startingStopName'],
          element['destinationStopName']);

      routelist.add(model);
      print("iseaasfaf" + userId.toString());
    });

    return routelist;
  }

  AddMyRoute(String StartStop, String DestinationStop) async {
    int userId = await getCurrentUserId();

    var routeData = await FirebaseDatabaseClass()
        .gerRouteIdAndBusStops(StartStop, DestinationStop);

   var result=await  supabase.from("MyRoutes").insert({
      "userId": userId,
      "routeId": routeData['routeIndex'],
      "startingStopName": StartStop,
      "destinationStopName": DestinationStop
    });

    print(result);
  }
}
