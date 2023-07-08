
import 'package:bustracker/Pages/PaymentPage.dart';
import 'package:flutter/material.dart';

import '../Components/ReviewCard.dart';
import '../Models/BusModel.dart';
import '../Models/ReviewModel.dart';
import '../backend/SupaBaseDatabase.dart';

class BusDetailsPage extends StatefulWidget {
  BusModel model;
BusDetailsPage(this.model);
  @override
  State<BusDetailsPage> createState() => _BusDetailsPageState();
}

class _BusDetailsPageState extends State<BusDetailsPage> {

  double width=0;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child:  Stack(
            children: [
              Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Container(
                            width: (76/100)*width,
                            
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                
                                
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.model.busName+" Bus",
                                        style: TextStyle(fontSize: 40,color: Colors.black),
                                      ),
                                    ),
                                  ),
                                 
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ItemCard("assets/icons/location.png", widget.model.busCurrentLocation),
                                  ItemCard("assets/icons/waste.png", widget.model.startingTime),
                                  ItemCard("assets/icons/license-plate.png", widget.model.busNumber),
                                   ItemCard("assets/icons/license-plate.png", widget.model.availableSeats.toString()),
                                  
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    children:  [
                                      Text(
                                        "Reviews",
                                        style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FutureBuilder(
                                      future: SupaBaseDatabase().getReviews(widget.model.busId),
                                      builder: (context, AsyncSnapshot<List<ReviewModel>> snap) {
                                        if (!snap.hasData) {
                                          return Text("Loading");
                                        } else {
                                          return Container(
                                            height: 250,
                                            child: ListView.builder(
                                                itemCount: snap.data!.length,
                                                itemBuilder: (context, index) {
                                                  return ReviewCard(snap.data![index]);
                                                }),
                                          );
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                         
                          width: (20/100)*width,
                        color: Colors.amber,
                        child: Column(children: [
                          SizedBox(height: 30,),
                          GestureDetector(
                            onTap: (){
                               // Navigator.push(context,MaterialPageRoute(builder:(context)=>BusReportPage(widget.model)));
                            },
                            child: Image.asset("assets/icons/document.png",height: 50,))
                        ],),
                       
                        )
                      ],
                    ),
                    Align(
                      
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PayementPage()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,width: 150,
                          
                          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 244, 142),borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text("Book Tickets",),
                          ),
                        ),
                      ),)
            ],
          ),
           
        ),
      ),
    );
  }

  Widget ItemCard(String icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 50,
      width: double.infinity,
     
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
           
             Image.asset(icon,height: 30,width: 30,),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300,color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
