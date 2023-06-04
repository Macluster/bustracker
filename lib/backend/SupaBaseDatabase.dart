import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/Models/PaymentModel.dart';
import 'package:bustracker/Models/StCardModel.dart';
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

    print(buslist);
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

  AddStCardDetails(StCardModel model) async {
    await supabase.from("StCard").insert({"userId": model.userId, "institutionName": model.institutionName, "institutionPlace": model.institutionPlace, "address": model.address, "issueDate": model.issueDate, "expiryDate": model.expiryDate, "status": model.status,"course":model.course,"courseDuration":model.courseDuration});
  }

  Future<Map<String,String>> GetStatusOFStCard() async {
    var userId = await getCurrentUserId();
    var result = await supabase.from("StCard").select("status,message").eq("userId", userId);
    print(result);
   
    return result!=null? { "status":result[0]["status"],"message":result[0]["message"]}: { "status":"","message":""};
  }

  Future<int> GetStIDOFStCard() async {
    var userId = await getCurrentUserId();
    var result = await supabase.from("StCard").select("stId").eq("userId", userId);
    print(result[0]["stId"]);
    return result[0]["stId"];
  }

  AddToStudentRoutes(int stId,String t1, String d1, String t2, String d2) async{

    await supabase.from("StudentRoutes").insert({"stId":stId,"from":t1,"to":d1});
    await supabase.from("StudentRoutes").insert({"stId":stId,"from":t2,"to":d2});
  }

  Future<StCardModel> GetStCardDetails()async
  {
        var userId = await getCurrentUserId();
       var result = await supabase.from("StCard").select().eq("userId", userId);
       print("jjj");

       return StCardModel(result[0]["stId"],userId, result[0]["institutionName"],result[0]["institutionPlace"] ,result[0]["address"], result[0]["issueDate"], result[0]["expiryDate"], result[0]["status"],result[0]["course"],result[0]["courseDuration"]);
  }


  Future<UserModel> getUserData()async
  {
       var userId = await getCurrentUserId();
       var result = await supabase.from("Users").select().eq("userId", userId);

      return UserModel(userId, result[0]["userName"], result[0]["userAdress"], result[0]["userDob"], result[0]["userPhone"], result[0]["userEmail"]);
     
  }


  Future<List<Map>> getStudentRoutes(int stid)async{

    var result = await supabase.from("StudentRoutes").select().eq("stId", stid);



        List<Map> list=[];

        list.add({"from":result[0]['from'],"to":result[0]['to']});
        list.add({"from":result[1]['from'],"to":result[1]['to']});


        return list;


  }
}
