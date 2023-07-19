import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/Models/PaymentModel.dart';
import 'package:bustracker/Models/SeniorCitizenModel.dart';
import 'package:bustracker/Models/StCardModel.dart';
import 'package:bustracker/Models/UserModel.dart';
import 'package:bustracker/backend/FirebaseDatabase.dart';
import 'package:bustracker/functions/GetWeekDayname.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Models/BusReportModel.dart';
import '../Models/MyRouteModel.dart';
import '../Models/ReviewModel.dart';

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

  Future<List<BusModel>> getBusData(
      int routeId, String currentBusStopOfUser, int routeDirection) async {
    int currentBusStopIDOfUser =
        await getbusStopIdusingName(currentBusStopOfUser);
    var date = DateTime.now();
    print(routeId);

    print(
        "\n\n**************************Fetching Bus Data with(GetBusData method)*************************\n\n");
    final data;
    if (routeDirection == 0) {
      print(currentBusStopIDOfUser);
      data = await supabase
          .from('Buses')
          .select()
          .eq("busRoute", routeId)
          .lt("busCurrentLocation", currentBusStopIDOfUser);
    } else {
      print(currentBusStopOfUser);
      data = await supabase
          .from('Buses')
          .select()
          .eq("busRoute", routeId)
          .gt("busCurrentLocation", currentBusStopIDOfUser);
      //  .lt("startingTime", "9:00:00");
    }

    // final data = await supabase.from('Buses').select().eq("busRoute", routeId).gt("busCurrentLocation", currentBusStopOfUser);

    var list = data as List;
    print("result:");
    print(list);

    List<BusModel> buslist = [];

    //Creating Model out of it
    BusModel? model;

    for (var i = 0; i < list.length; i++) {
      var busStopName =
          await getBusStopNameUsingId(list[i]['busCurrentLocation']);

      model = BusModel(
          list[i]['busId'],
          list[i]['busName'],
          list[i]['busRoute'],
          list[i]['busNumber'],
          busStopName,
          list[i]['startStop'],
          list[i]['endStop'],
          list[i]['startingTime'],
          list[i]['availableSeats'],
          list[i]['averageSpeed'],
          0);

      buslist.add(model!);
    }

    print(
        "**************************************************************************");

    return buslist;
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

  Future<String> getBusStopNameUsingId(int id) async {
    var data = await supabase
        .from("BusStops")
        .select("busStopName")
        .eq("busStopId", id);

    var nameData = data as List;

    return nameData[0]['busStopName'];
  }

  void Addpayement(
      int userId, int busId, int fare, String from, String to) async {
    var date = DateTime.now();
    var weekday = date.weekday;
    var mydate = "${date.year}-${date.month}-${date.day}";
    //  var dateFormat = "${GetWeekDayName(weekday)} $mydate";

    var result = await supabase.from("Payment").insert({
      "userId": userId,
      "busId": busId,
      "fromBusStop": from,
      "date": mydate,
      "toBusStop": to,
      "busFare": fare
    });
    print(result.toString());
  }

////////////////////////////////  For Dealing favarite routes   //////////////////////////////////////////////////////////

  // to get favorite route data from supabase as stream  for passing it to the below function
  Stream GetMyRouteStream(int userId) {
    return supabase
        .from('MyRoutes')
        .stream(primaryKey: ["myRouteId"])
        .eq('userId', userId)
        .map((event) {
          return event;
        });
  }

  // To make the favorite data gor from GetMyRouteStream  to MyRoutesModel
  // to be used for  favorite routes that we create
  List<MyRouteModel> getMyroutesModelList(var snap) {
    List<MyRouteModel> routelist = [];
    var model = MyRouteModel(1, 2, 2, " ", " ");

    snap.forEach((element) {
      model = MyRouteModel(
          element['myRouteId'],
          element['userId'],
          element['routeId'],
          element['startingStopName'],
          element['destinationStopName']);

      routelist.add(model);
    });

    return routelist;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  AddMyRoute(String StartStop, String DestinationStop) async {
    int userId = await getCurrentUserId();

    var routeData = await FirebaseDatabaseClass()
        .gerRouteIdAndBusStops(StartStop, DestinationStop);

    var result = await supabase.from("MyRoutes").insert({
      "userId": userId,
      "routeId": routeData['routeIndex'],
      "startingStopName": StartStop,
      "destinationStopName": DestinationStop
    });
  }

  Future<List<PayementModel>> getHistory() async {
    var id = await getCurrentUserId();
    List result = await supabase.from("Payment").select().eq("userId", id);

    PayementModel model = PayementModel(1, 1, 1, "", "", 1, "");

    List<PayementModel> list = [];

    result.forEach((element) {
      model = PayementModel(
          element['paymentId'],
          element['busId'],
          element['userId'],
          element['fromBusStop'],
          element['toBusStop'],
          element['busFare'],
          element["date"]);

      list.add(model);
    });

    return list;
  }

  AddStCardDetails(StCardModel model, String action) async {
    var stid = 1;
    if (action == "update") {
      var data = await supabase
          .from("StCard")
          .select("stId")
          .eq("userId", model.userId);
      stid = data[0]["stId"];
    }

    var map = {
      "userId": model.userId,
      "institutionName": model.institutionName,
      "institutionPlace": model.institutionPlace,
      "address": model.address,
      "issueDate": model.issueDate,
      "expiryDate": model.expiryDate,
      "status": model.status,
      "course": model.course,
      "courseDuration": model.courseDuration
    };

    if (action == "insert") {
      await supabase.from("StCard").insert(map);
    }
    {
      await supabase.from("StCard").update(map).eq("stId", stid);
    }
  }

  AddSeniorCitizenDetails(SeniorCitizenModel model) async {
    await supabase.from("SeniorCitizens").insert({
      "userId": model.userId,
      "status": model.status,
      "message": model.message,
      "age": model.age
    });
  }

  Future<Map<String, String>> GetStatusOFStCard() async {
    var userId = await getCurrentUserId();
    var result = await supabase
        .from("StCard")
        .select("status,message")
        .eq("userId", userId);

    return result != null
        ? {"status": result[0]["status"], "message": result[0]["message"] ?? ""}
        : {"status": "", "message": ""};
  }

  Future<Map<String, String>> GetStatusOFSenioCitizenShipCard() async {
    var userId = await getCurrentUserId();
    List result = await supabase
        .from("SeniorCitizens")
        .select("status,message")
        .eq("userId", userId);

    return result.isNotEmpty
        ? {"status": result[0]["status"], "message": result[0]["message"]}
        : {"status": "", "message": ""};
  }

  Future<int> GetStIDOFStCard() async {
    var userId = await getCurrentUserId();
    var result =
        await supabase.from("StCard").select("stId").eq("userId", userId);
    return result[0]["stId"];
  }

  AddToStudentRoutes(int stId, String t1, String d1, String t2, String d2,
      String action) async {
    var id1 = 1;
    var id2=2;
    if (action == "update") {
      var data = await supabase
          .from("StudentRoutes")
          .select("id")
          .eq("stId", stId);
      id1 = data[0]["id"];

        
      id2 = data[1]["id"];
    }

    print(t1 + t2 + d1 + d2);
    if (action == "update") {
      await supabase
          .from("StudentRoutes")
          .update({"stId": stId, "from": t1, "to": d1}).eq("id", id1);
      await supabase
          .from("StudentRoutes")
          .update({"stId": stId, "from": t2, "to": d2}).eq("id", id2);
    } else {
      await supabase
          .from("StudentRoutes")
          .insert({"stId": stId, "from": t1, "to": d1});
      await supabase
          .from("StudentRoutes")
          .insert({"stId": stId, "from": t2, "to": d2});
    }
  }

  addFormPhotoUrl(String url) async {
    var userId = await getCurrentUserId();
    await supabase
        .from("StCard")
        .update({"formImage": url}).eq("userId", userId);
  }

  addProilePhotoUrl(String url) async {
    var userId = await getCurrentUserId();
    await supabase.from("StCard").update({"photo": url}).eq("userId", userId);
  }

  Future<StCardModel> GetStCardDetails() async {
    var userId = await getCurrentUserId();
    var result = await supabase.from("StCard").select().eq("userId", userId);

    return StCardModel(
        result[0]["stId"],
        userId,
        result[0]["institutionName"],
        result[0]["institutionPlace"],
        result[0]["address"],
        result[0]["issueDate"],
        result[0]["expiryDate"],
        result[0]["status"],
        result[0]["course"],
        result[0]["courseDuration"]);
  }

  Future<UserModel> getUserData() async {
    var userId = await getCurrentUserId();
    var result = await supabase.from("Users").select().eq("userId", userId);

    return UserModel(userId, result[0]["userName"], result[0]["userAdress"],
        result[0]["userDob"], result[0]["userPhone"], result[0]["userEmail"]);
  }

  Future<List<Map>> getStudentRoutes(int stid) async {
    var result = await supabase.from("StudentRoutes").select().eq("stId", stid);

    List<Map> list = [];

    list.add({"from": result[0]['from'], "to": result[0]['to']});
    list.add({"from": result[1]['from'], "to": result[1]['to']});

    return list;
  }

  Future<List<ReviewModel>> getReviews(int busId) async {
    final data = await supabase.from('Review').select().eq("busId", busId);
    var list = data as List;

    List<ReviewModel> reviewlist = [];

    for (int i = 0; i < list.length; i++) {
      var name = await supabase
          .from('Users')
          .select("userName")
          .eq("userId", list[i]['userId'])
          .single();

      reviewlist.add(ReviewModel(list[i]['id'], list[i]['review'],
          list[i]['rating'], name['userName']));
    }

    return reviewlist;
  }

  Future<List<BusReportModel>> getBusReport(
      String startDate, String endDate) async {
    List data = [];
    int id = await getCurrentUserId();
    if (startDate == "" ||
        endDate == "" ||
        startDate == "null" ||
        endDate == "null") {
      data = await supabase.from('Payment').select().eq("userId", id);
    } else {
      data = await supabase
          .from('Payment')
          .select()
          .eq("userId", id)
          .lt("date", endDate)
          .gt("date", startDate);
    }
    var list = data as List;

    List<BusReportModel> reportlist = [];

    for (int i = 0; i < list.length; i++) {
      var userData = await supabase
          .from('Users')
          .select("userName,userDob")
          .eq("userId", list[i]['userId'])
          .single();
      var busName = await supabase
          .from('Buses')
          .select("busName")
          .eq("busId", list[i]['busId'])
          .single();

      reportlist.add(BusReportModel(
          busName['busName'],
          userData['userName'],
          list[i]['date'],
          list[i]['fromBusStop'],
          list[i]['toBusStop'],
          list[i]['busFare'],
          userData['userDob']));
    }

    return reportlist;
  }

  Future<bool> lookIfStConssesionAvailable() async {
    int id = await getCurrentUserId();
    final data = await supabase.from('StCard').select().eq("userId", id);
    var list = data as List;
    if (list.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> lookIfElderConssesionAvailable() async {
    int id = await getCurrentUserId();
    final data =
        await supabase.from('SeniorCitizens').select().eq("userId", id);
    var list = data as List;
    if (list.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> getbusStopIdusingName(String busStopName) async {
    final data = await supabase
        .from("BusStops")
        .select("busStopId")
        .eq("busStopName", busStopName);
    return data[0]['busStopId'];
  }

  Future<List<String>> getBusStopName() async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    final data = await supabase.from("BusStops").select("busStopName");

    List<String> list = [];
    data.forEach((ele) {
      list.add(ele['busStopName']);
    });

    return list;
  }

  Future<String> getBusNameUsingId(int id) async {
    var data = await supabase.from("Buses").select("busName").eq("busId", id);

    var nameData = data as List;

    return nameData[0]['busName'];
  }

  addReview(int rating, String review, int busId) async {
    int id = await getCurrentUserId();
    await supabase.from("Review").insert(
        {"review": review, "rating": rating, "userId": id, "busId": busId});
  }
}
