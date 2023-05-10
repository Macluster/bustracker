import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/Models/PaymentModel.dart';
import 'package:bustracker/Models/UserModel.dart';
import 'package:bustracker/backend/FirebaseDatabase.dart';
import 'package:bustracker/functions/GetWeekDayname.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Models/MyRouteModel.dart';

class SupaBaseDatabase {
  final supabase = Supabase.instance.client;

  void AddUserDetails(UserModel model) async {
    await supabase.from("Users").insert({"userName": model.userName, "userAdress": model.userAddress, "userPhone": model.userPhone, "userEmail": model.userEmail, "userDob": model.userDob});
  }

  Future<List<BusModel>> GetBusData(int routeId, int currentBusStopOfUser) async {
    final data = await supabase.from('Buses').select().eq("busRoute", routeId).gt("busCurrentLocation", currentBusStopOfUser);

    var list = data as List;

    List<BusModel> buslist = [];

    BusModel? model;
    var routes = await FirebaseDatabaseClass().getBusStopNameFromID();

    list.forEach((element) async {
      var busStopName = routes[routeId][element['busCurrentLocation']].toString();

      model = BusModel(element['busId'], element['busName'], element['busRoute'], element['busNumber'], busStopName, element['startStop'], element['endStop'], element['startingTime']);

      buslist.add(model!);
    });

    return buslist;
  }

  Future<int> GetUserStopNameUsingid(String email) async {
    List data = await supabase.from("BusStops").select("busStopName").eq("userEmail", email) as List;
    print("userId=" + data[0]['userId'].toString());

    return data[0]['userId'] as int;
  }

  Future<int> getCurrentUserId() async {
    var email = Supabase.instance.client.auth.currentUser!.email;
    List data = await supabase.from("Users").select("userId").eq("userEmail", email) as List;
    print("userId=" + data[0]['userId'].toString());

    return data[0]['userId'] as int;
  }

  void Addpayement(int userId, int busId, int fare, String from, String to) async {
    var date = DateTime.now();
    var weekday = date.weekday;
    var mydate = "${date.day}/${date.month}/${date.year}";
    var dateFormat = "${GetWeekDayName(weekday)} $mydate";

    print("userid is " + from);
    var result = await supabase.from("Payment").insert({"userId": userId, "busId": busId, "fromBusStop": from, "date": dateFormat, "toBusStop": to, "busFare": fare});
    print(result.toString());
  }

  Stream GetMyRouteStream(int userId) {
    print("hhhhh" + userId.toString());
    return supabase.from('MyRoutes').stream(primaryKey: ["myRouteId"]).eq('userId', userId).map((event) {
          return event;
        });
  }

  List<MyRouteModel> getMyroutes(var snap) {
    List<MyRouteModel> routelist = [];
    var model = MyRouteModel(1, 2, 2, " ", " ");
    // var result =
    //    await supabase.from('MyRoutes').select().eq('userId', userId) as List;

    snap.forEach((element) {
      print(element['sartingStopName']);
      model = MyRouteModel(element['myRouteId'], element['userId'], element['routeId'], element['startingStopName'], element['destinationStopName']);

      routelist.add(model);
    });

    return routelist;
  }

  AddMyRoute(String StartStop, String DestinationStop) async {
    int userId = await getCurrentUserId();

    var routeData = await FirebaseDatabaseClass().gerRouteIdAndBusStops(StartStop, DestinationStop);

    var result = await supabase.from("MyRoutes").insert({"userId": userId, "routeId": routeData['routeIndex'], "startingStopName": StartStop, "destinationStopName": DestinationStop});

    print(result);
  }

  Future<List<PayementModel>> getHistory(int id) async {
    List result = await supabase.from("Payment").select().eq("userId", id);

    PayementModel model = PayementModel(1, 1, 1, "", "", 1, "");

    List<PayementModel> list = [];

    result.forEach((element) {
      model = PayementModel(element['paymentId'], element['busId'], element['userId'], element['fromBusStop'], element['toBusStop'], element['busFare'], element["date"]);

      list.add(model);
    });

    return list;
  }
}
