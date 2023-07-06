


import 'package:bustracker/Models/PaymentModel.dart';
import 'package:bustracker/Pages/TicketPage.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTravelsPage extends StatefulWidget
{
  @override
  State<MyTravelsPage> createState() => _MyTravelsPageState();
}

class _MyTravelsPageState extends State<MyTravelsPage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(width: double.infinity,
          
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children:  [
              Text("My  Travels",style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 50,),
              FutureBuilder(
                future: SupaBaseDatabase().getHistory(),
                builder: (context,AsyncSnapshot<List<PayementModel>> snap){
                if(snap.hasData)
                {
                  return Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context,index){
                      return MyTripCard(snap.data![index]);
                    }),
                  );
                }
                else
                {
                  return Text("Loading");
                }
              })


            ],),
          ),
          ),
        ),

      );
  }
}


class MyTripCard extends StatelessWidget {
  PayementModel model;

  MyTripCard(this.model);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
  Navigator.push(context, MaterialPageRoute(builder: (context)=> TicketPage(model)));        },
        child: Container(
          height: 100,
          width: 220,
          margin: EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      model.from + " to " + model.to,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text(model.date, style: Theme.of(context).textTheme.labelSmall),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}