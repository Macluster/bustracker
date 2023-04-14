import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(titleLarge: TextStyle(fontSize: 30,color: Colors.red)),
       
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
  

 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    
    body: SizedBox(width: double.infinity,
    child: Column(children: [
      const SizedBox(height: 100,),
    Text("Login" ,style: Theme.of(context).textTheme.titleLarge,),
    const SizedBox(height: 100,),
    Container(
      width: 250,
      child: TextField(decoration: InputDecoration(hintText: "User name"),)),
      Container(
      width: 250,
      child: TextField(decoration: InputDecoration(hintText: "Password"),)),
      const SizedBox(height: 50,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const  [
          Text("Dont have an acoount",),
          SizedBox(width: 10,),
           Text("Click Here", style: TextStyle(color: Colors.blue),)
        ],
      ),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const  [
          Text("Dont have an acoount",),
          SizedBox(width: 10,),
           Text("Click Here", style: TextStyle(color: Colors.blue),)
        ],
      )
    ],),
    
    ),
    );
  }
}
