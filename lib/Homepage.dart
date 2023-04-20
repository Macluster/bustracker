

import 'package:bustracker/LoginPage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget
{
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: SizedBox(width: double.infinity,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text("My routes",style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 10,),
              Container(
                height: 150,
                width: double.infinity,
                
                child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                  
                  itemCount: 2,
                  itemBuilder: (context,index){
                   
                      return MyRoutesCard();
                  }),
              ),
              SizedBox(height: 50,),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color:Colors.amber),
                child: Text("New Route",style: Theme.of(context).textTheme.labelLarge,),)
              ],
                
           ),
         ),
         ),
       ),

     );
  }

}


var myroutesList=[];

class MyRoutesCard extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      margin: EdgeInsets.only(right: 10),
      decoration: const  BoxDecoration(
        
        
        color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Icon(Icons.location_city,size: 40,),
          SizedBox(height: 20,),
          
          Text("Kundanoor to Kalamaserry",style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,)
          ],
        ),
    );
  }

}