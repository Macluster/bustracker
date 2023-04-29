import 'package:bustracker/Models/BusModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseDatabase {
  final supabase = Supabase.instance.client;

  Future<List<BusModel>> GetBusData(int routeId, int currentBusStop) async {
    final data = await supabase
        .from('Buses')
        .select()
        .eq("busRoute", routeId)
        .gt("busCurrentLocation", currentBusStop);

    var list = data as List;

    List<BusModel> buslist = [];

    BusModel? model;
    list.forEach((element) {
      model = BusModel(
          element['busId'],
          element['busName'],
          element['busRoute'],
          element['busNumber'],
          element['busCurrentLocation'],
          element['startStop'],
          element['endStop'],
          element['startingTime']);

      buslist.add(model!);
    });
    
    return buslist;
  }
}
