import 'dart:ui';

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
      backgroundColor: Color.fromARGB(255, 147, 137, 154),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/icons/morning.png"))),
                      height: 400,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Text(
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
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DetailCard("kalamassery Bus Stop", Icons.location_on),
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
          color: Color.fromARGB(255, 234, 232, 225),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: 40,
        ),
        Icon(
          icon,
          size: 30,
        ),
        Container(
            width: 200,
            child: Text(
              content,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            )),
        SizedBox(
          width: 40,
        ),
      ]),
    );
  }
}
