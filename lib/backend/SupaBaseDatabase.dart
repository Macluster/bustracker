import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseDatabase {
  final supabase = Supabase.instance.client;

  void GetBusData(int routeId) async {
    final data = await supabase.from('Buses').select().eq("busRoute", routeId);
    print(data.toString());
  }
}
