import 'package:flutter/material.dart';
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
      SizedBox(height: 50,),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
  SignInCard("https://www.google.com/imgres?imgurl=https%3A%2F%2Fassets.stickpng.com%2Fimages%2F5847f9cbcef1014c0b5e48c8.png&tbnid=6iDpAdyA65M1MM&vet=12ahUKEwjk0Pfj5Kj-AhWbFLcAHSCTCpcQMygAegUIARDHAQ..i&imgrefurl=https%3A%2F%2Fwww.stickpng.com%2Fimg%2Ficons-logos-emojis%2Ftech-companies%2Fgoogle-g-logo&docid=v61A3qKPMcJtPM&w=500&h=512&q=google%20transparent%20icon&ved=2ahUKEwjk0Pfj5Kj-AhWbFLcAHSCTCpcQMygAegUIARDHAQ")
        ],
      )
    ],),
    
    ),
    );
  }
}


class SignInCard extends StatelessWidget
{
  
  String imageLink="";
  SignInCard(this.imageLink);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Image.network(imageLink),
      height: 50,width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),color: Colors.white,boxShadow: [BoxShadow(blurRadius: 10,spreadRadius: 10,color: Color.fromARGB(255, 246, 242, 242))]));
  }

}
