import 'dart:ui';

import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/Pages/PaymentPage.dart';
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
            body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 100,),
                 Text(
                          widget.model.busName + " Bus",
                          style: const TextStyle(
                              shadows: [
                                Shadow(
                                    offset: Offset(5, 0),
                                    blurRadius: 4,
                                    color: Colors.grey)
                              ],
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 58, 57, 57)),
                        ),
                   
                  const SizedBox(
                    height: 30,
                  ),
                  DetailCard(widget.model.busCurrentLocation, Icons.location_on),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailCard("KL 8456 33", Icons.numbers),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailCard("Private Bus", Icons.bus_alert),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailCard("10Rs", Icons.money),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PayementPage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: double.infinity,
                  color: Colors.amber,
                  child: const Text("Book tikcet"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  String content = "";
  IconData icon;

  DetailCard(this.content, this.icon);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      width: (screenWidth) - 30,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 3,color: Color.fromARGB(255, 240, 232, 232),spreadRadius: 2)],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child:ListTile(leading: Icon(icon),title: Text(
              content,
              style: Theme.of(context).textTheme.labelSmall,
          
            ),)
    );
  }
}
