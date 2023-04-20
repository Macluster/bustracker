


import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget
{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      SizedBox(height: 40,),
      Container(
      width: 250,
      child: TextField(decoration: InputDecoration(hintText: "Password"),)),
      const SizedBox(height: 50,),
      Container(
        alignment: Alignment.center,
        height: 35,
        width: 100,
        decoration:const  BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text("Login"),
        ),

        SizedBox(height: 30,),
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
         SignInCard('assets/icons/google.png'),
         SizedBox(width: 50,),
          SignInCard('assets/icons/facebook.png')
        ],
      )
    ],),
    
    )
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
      
      child: Image.asset(imageLink),
      height: 50,width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),color: Colors.white,boxShadow: [BoxShadow(blurRadius: 10,spreadRadius: 10,color: Color.fromARGB(255, 246, 242, 242))]));
  }

}