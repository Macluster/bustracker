import 'package:bustracker/Homepage.dart';
import 'package:bustracker/LoginPage.dart';
import 'package:bustracker/Models/MenuItems.dart';
import 'package:bustracker/SidebarNavBar.dart';
import 'package:bustracker/backend/FirebaseDatabase.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://ogwbsawdfrfragnjwrhu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9nd2JzYXdkZnJmcmFnbmp3cmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI2MTIxNzcsImV4cCI6MTk5ODE4ODE3N30.K-QINUpml_pmIyvgsWZfmEC_RtfW-t7Ewz8v-SCbvqg',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
            headlineMedium: TextStyle(
                fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
            headlineLarge: TextStyle(
                fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black),
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
            bodyMedium: TextStyle(fontSize: 24),
            bodySmall: TextStyle(fontSize: 15),
            labelSmall: TextStyle(
              fontSize: 17,
            ),
            labelMedium: TextStyle(
              fontSize: 20,
            )),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentItem = 0;
  var pages = [Homepage(), LoginPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: ZoomDrawer(
          style: DrawerStyle.defaultStyle,
          mainScreen: pages[currentItem],
          menuScreen: SidenavBar((item) {
            setState(() {
              this.currentItem = item;
            });
          }),
        ));
  }
}

class SignInCard extends StatelessWidget {
  String imageLink = "";
  SignInCard(this.imageLink);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(imageLink),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 10,
                  color: Color.fromARGB(255, 246, 242, 242))
            ]));
  }
}
