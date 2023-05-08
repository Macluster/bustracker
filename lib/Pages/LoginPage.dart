


import 'dart:io';

import 'package:bustracker/Components/DraweContainer.dart';
import 'package:bustracker/Pages/EnterUserDetailsPage.dart';
import 'package:bustracker/Pages/Homepage.dart';
import 'package:bustracker/Pages/SignUpPage.dart';
import 'package:bustracker/Providers/UserProvider.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:bustracker/backend/SupabaseAuthentication.dart';
import 'package:bustracker/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget
{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(width: double.infinity,
    child: Column(children: [
      const SizedBox(height: 100,),
    Text("Login" ,style: Theme.of(context).textTheme.titleLarge,),
    const SizedBox(height: 100,),
    Container(
      width: 250,
      child: TextField(
        controller: emailController,
        style: Theme.of(context).textTheme.bodySmall ,
        decoration: InputDecoration(hintText: "User name",hintStyle: Theme.of(context).textTheme.bodySmall),)),
      SizedBox(height: 40,),
      Container(
      width: 250,
      child: TextField(

         style: Theme.of(context).textTheme.bodySmall ,
       controller: passwordController, 
        decoration: InputDecoration(hintText: "Password",hintStyle: Theme.of(context).textTheme.bodySmall),)),
      const SizedBox(height: 50,),
      GestureDetector(

        onTap: ()async{
          SupabaseAuthentication().LogIn(emailController.text, passwordController.text);

          int id=await SupaBaseDatabase().getCurrentUserId();
          context.read<UserProvider>().setCurrentUserId(id);
          
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerContainer()));
        },
        child: Container(
          alignment: Alignment.center,
          height: 35,
          width: 100,
          decoration:const  BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text("Login"),
          ),
      ),

        SizedBox(height: 100,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Dont have an acoount",style: Theme.of(context).textTheme.bodySmall,),
          SizedBox(width: 10,),
           GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
            },
            child: Text("Click Here", style: TextStyle(color: Colors.blue,fontSize: 15),))
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