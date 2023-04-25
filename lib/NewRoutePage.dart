import 'package:bustracker/BusDetailsPage.dart';
import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/data.dart';
import 'package:flutter/material.dart';

class NewRoutePage extends StatefulWidget {
  @override
  State<NewRoutePage> createState() => _NewRoutePageState();
}

class _NewRoutePageState extends State<NewRoutePage> {
  String currentBusStop = "";
  String destinationStop = "";

  double screenHeight = 0.0;
  double screenWidth = 0.0;
  var myRoot = [];
  var busesInMyroute = [];
  int routeIndex = 0;

  void getRoute() {
    routes.asMap().forEach((index, route) {
      if (route.contains(currentBusStop) && route.contains(destinationStop)) {
        routeIndex = index;
        int currentstopIndex = route.indexOf(currentBusStop);
        int destinationStopIndex = route.indexOf(destinationStop);
        for (int i = currentstopIndex; i <= destinationStopIndex; i++) {
          myRoot.add(routes[routeIndex][i]);
        }

        setState(() {});
      }
    });
  }

  void getBusesInMyRoute() {
    buses.forEach((element) {
      if (element.busroute == routeIndex) {
        busesInMyroute.add(element);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: Icon(Icons.arrow_back),
        title:                 Text("Select the Route",style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [

                Container(
                    width: screenWidth - 10,
                    child: DropdownButton(
                        iconSize: 30,
                        iconEnabledColor: Colors.white,
                        hint: Text(
                          currentBusStop == ""
                              ? "Current Bus stop"
                              : currentBusStop,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        items: bustops
                            .map((item) => DropdownMenuItem(
                              
                                  value: item['name'].toString(),
                                      child:  Text(
                                    item['name'].toString(),
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ))
                            .toList(),
                        onChanged: (e) {
                          setState(() {
                            currentBusStop = e.toString();
                          });
                        })),
                Container(
                    width: screenWidth - 10,
                    child: DropdownButton(
                        iconSize: 30,
                        iconEnabledColor: Colors.white,
                        hint: Text(
                          destinationStop == ""
                              ? "Destination Bus stop"
                              : destinationStop,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        items: bustops
                            .map((item) => DropdownMenuItem(
                                 
                                  value: item['name'].toString(),
                                   child: Text(
                                    item['name'].toString(),
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ))
                            .toList(),
                        onChanged: (e) {
                          setState(() {
                            destinationStop = e.toString();
                            getRoute();
                            getBusesInMyRoute();
                          });
                        })),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var stop in myRoot)
                          Row(
                            children: [
                              Text(
                                stop,
                                style: TextStyle(fontSize: 20),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.red,
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                 Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Available buses in this route",
                      style:
                          Theme.of(context).textTheme.titleMedium
                    )),
                for (var item in busesInMyroute) BusCard(item)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BusCard extends StatelessWidget {
  BusModel model;

  BusCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const  BoxDecoration(
          color: Color.fromARGB(255, 236, 222, 221),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topLeft,
      height: 80,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.busName,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  "Current Location: KannadiKadu bus stop",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BusDetailsPage(model)));
              },



              
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
