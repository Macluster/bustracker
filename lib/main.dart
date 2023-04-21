import 'package:bustracker/Homepage.dart';
import 'package:bustracker/LoginPage.dart';
import 'package:bustracker/SidebarNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 30,
              color: Colors.red,
            ),
            titleMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            bodySmall: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
            bodyMedium: TextStyle(fontSize: 24),
            labelLarge: TextStyle(
              fontSize: 20,
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
  var widgets = [
    Homepage(),
    LoginPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: ZoomDrawer(
          style: DrawerStyle.defaultStyle,
          mainScreen: Homepage(),
          menuScreen: SidenavBar(),
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
