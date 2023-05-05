import 'dart:ffi';

import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/Models/UserModel.dart';
import 'package:bustracker/backend/FirebaseDatabase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseDatabase {
  final supabase = Supabase.instance.client;

  void AddUserDetails(UserModel model)async
  {
     await supabase.from("Users").insert({"userName":model.userName,"userAdress":model.userAddress,"userPhone":model.userPhone,"userEmail":model.userEmail,"userDob":model.userDob});
  }

  Future<List<BusModel>> GetBusData(int routeId, int currentBusStop) async {
    final data = await supabase
        .from('Buses')
        .select()
        .eq("busRoute", routeId)
        .gt("busCurrentLocation", currentBusStop);

    var list = data as List;

    List<BusModel> buslist = [];

    BusModel? model;
    list.forEach((element) async{



    String busStopName= await FirebaseDatabaseClass().getBusStopNameFromID(element['busCurrentLocation'], routeId);
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



  Future<int> GetUserStopNameUsingid(String email)async
    {

      List data=await supabase.from("BusStops").select("busStopName").eq("userEmail",email ) as List ;
      print("userId="+data[0]['userId'].toString());

      return data[0]['userId'] as int;

    }


     Future<int> GetUserIdUsingEmail(String email)async
    {

      List data=await supabase.from("Users").select("userId").eq("userEmail",email ) as List ;
      print("userId="+data[0]['userId'].toString());

      return data[0]['userId'] as int;

    }


  void Addpayement(int userId,int busId, int fare,String from,String to)async
  {
    print("userid is "+from);
    var result= await supabase.from("Payment").insert({"userId":userId,"busId":busId,"fromBusStop":from,"date":"fasf","toBusStop":to,"busFare":fare});
    print(result.toString());
  
  }
}
