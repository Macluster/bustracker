import 'package:bustracker/Models/StCardModel.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowStCardPage extends StatefulWidget {
  @override
  State<ShowStCardPage> createState() => _ShowStCardPageState();
}



class _ShowStCardPageState extends State<ShowStCardPage> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  StCardModel model=StCardModel(0, "","", "", "","", "");

  void getData()async
  {
      model=await SupaBaseDatabase().GetStCardDetails();
      setState(() {
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [Text("ST Card",style: Theme.of(context).textTheme.titleLarge,), SizedBox(height: 50,),FlipCard(front: CardFrontSide(), back: CardBackSide())],
            ),
          ),
        ),
      ),
    );
  }

  Widget CardFrontSide() {
    return Container(
      height: 700,
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 3), color: Colors.white, boxShadow: [BoxShadow(color: Color.fromARGB(255, 230, 224, 224), blurRadius: 5, spreadRadius: 5)]),
      child: Column(
        children: [
          Image.asset(
            'assets/icons/gover.png',
            height: 100,
            width: 100,
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.red,
            width: double.infinity,
            height: 30,
            child: const Text(
              "STUDENT CONCESSION CARD",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.yellow,
            width: double.infinity,
            height: 30,
            child: const Text(
              "PRIVATE BUS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/icons/dq.jpg',
            height: 150,
            width: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StudentInfoItem("Name", "Deepak Denny"),
                StudentInfoItem("Age", "23 Years"),
                StudentInfoItem("Dob", "21/7/2000"),
                StudentInfoItem("Institution Name", model.institutionName),
                StudentInfoItem("Course", "IMCA "),
                StudentInfoItem("Duration of Course", "5 Years "),
                StudentInfoItem("Date of Issue", model.issueDate),
                StudentInfoItem("Date of Expiry", model.expiryDate),
              const  SizedBox(
                  height: 30,
                ),
                const Text(
                  "Commision Routes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                RouteCard(),
                RouteCard(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CardBackSide() {
    return Container(
      height: 700,
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 3), color: Colors.white, boxShadow: [BoxShadow(color: Color.fromARGB(255, 230, 224, 224), blurRadius: 5, spreadRadius: 5)]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
           Container(
            alignment: Alignment.center,
            height: double.infinity,width: 40,color: Colors.yellow,child: RotatedBox(quarterTurns: -1,child:Text("Address Of Communication")),),
            SizedBox(width: 10),
          Container(height: double.infinity,width: 100,decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 3),),),
             SizedBox(width: 10),
         Container(
            alignment: Alignment.center,
            height: double.infinity,width: 40,color: Colors.yellow,child: RotatedBox(quarterTurns: -1,child:Text("Name and Address Institution ")),),
                         SizedBox(width: 10),
                   Container(height: double.infinity,width: 100,decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 3),),),

         
          ],
        ),
      ),
    );
  }

  Widget RouteCard() {
    return Row(
      children: [
        Container(
            width: 150,
            child: Text(
              "Kundanoor",
              style: Theme.of(context).textTheme.labelSmall,
            )),
        Text(
          "to",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(
          width: 40,
        ),
        Text(
          "kalamaserry",
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }

  Widget StudentInfoItem(String label, String content) {
    return Row(
      children: [
        Container(
            width: 160,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
            )),
        Text(
          ":",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 150,
          child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            content,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ) ,)
       
      ],
    );
  }
}
