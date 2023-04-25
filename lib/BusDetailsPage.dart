import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/PaymentPage.dart';
import 'package:flutter/material.dart';

class BusDetailsPage extends StatefulWidget {
  BusModel model;

  BusDetailsPage(this.model);
  @override
  State<BusDetailsPage> createState() => _BusDetailsPageState();
}

class _BusDetailsPageState extends State<BusDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(widget.model.busName,style: Theme.of(context).textTheme.titleLarge
                    ,),
                       const  SizedBox(height: 50,),
             DetailCard("kalamassery Bus Stop",Icons.location_on),
             SizedBox(height: 10,),
              DetailCard("KL 8456 33",Icons.numbers),
              SizedBox(height: 10,),
              DetailCard("Private Bus",Icons.bus_alert), 
              SizedBox(height: 10,),
              DetailCard("10Rs",Icons.money),
                  ],
                ),
            
          
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PayementPage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 70,width: double.infinity, color: Colors.amber,
                child: const  Text("Book tikcet"),
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class DetailCard extends StatelessWidget {

  String content="";
  IconData icon;

  DetailCard(this.content,this.icon);

  @override
  Widget build(BuildContext context) {

    var screenWidth=MediaQuery.of(context).size.width;
    return Container(
      height:60,
      width:  (screenWidth)-30,
      decoration: const  BoxDecoration(
          color: Color.fromARGB(255, 234, 232, 225),
          borderRadius: BorderRadius.all(Radius.circular(5))),
  
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 40,),
      
        Icon(icon,size: 30,),
        Container(
            width: 200,
            child: Text(content,style: Theme.of(context).textTheme.labelSmall,textAlign: TextAlign.center,)),
        
                  SizedBox(width: 40,),

      ]),
  
    );
  }
}
