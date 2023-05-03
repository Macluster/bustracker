import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthentication
{


Future<String> signupEmailAndPassword(String email, String password) async {
  var supabase=Supabase.instance;
  final response = await supabase.client.auth.signUp(email: email,password: password);


  final userId = response.user?.id;
  if (userId == null) {
    throw UnimplementedError();
  }

  return userId;
}

Future<String> LogIn(String email, String password) async {
  var supabase=Supabase.instance;
  final response = await supabase.client.auth.signInWithPassword(email: email,password: password);


  final userId = response.user?.id;
  if (userId == null) {
    throw UnimplementedError();
  }

  return userId;
}


 void SignOut()async
 {
      await  Supabase.instance.client.auth.signOut();
 }




}