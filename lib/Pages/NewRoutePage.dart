import 'package:bustracker/Components/DropDownList.dart';
import 'package:bustracker/Pages/BusDetailsPage.dart';
import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/backend/FirebaseDatabase.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:bustracker/backend/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/PaymentProvider.dart';

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

  Future<void> getRoute() async {
    var routes = await FirebaseDatabaseClass().GetRoute();

    context.read<PayementProvider>().setfromBusStop(currentBusStop);
    context.read<PayementProvider>().setToBusStop(destinationStop);
    context.read<PayementProvider>().setFare(20);

    routes.asMap().forEach((index, route) {
      if (route.contains(currentBusStop) && route.contains(destinationStop)) {
        routeIndex = index;
        print(routeIndex);
        int currentstopIndex = route.indexOf(currentBusStop);
        int destinationStopIndex = route.indexOf(destinationStop);
        for (int i = currentstopIndex; i <= destinationStopIndex; i++) {
          myRoot.add(routes[routeIndex][i]);
        }

        setState(() {});
      }
    });
  }

  void getBusesInMyRoute() async {
    var buses = await SupaBaseDatabase().GetBusData(routeIndex, 3);

    buses.forEach((element) {
      print(element);
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
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: Icon(Icons.arrow_back),
        title: Text(
          "Select the Route",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                DropDownList(bustops, currentBusStop, "Current Bus stop", (e) {
                  setState(() {
                    currentBusStop = e.toString();
                  });
                }),
                DropDownList(bustops,destinationStop, "Destination Bus stop", (e) async {
                  setState(() {
                    destinationStop = e.toString();
                  });
                  await getRoute();
                  getBusesInMyRoute();
                }),
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
                    child: Text("Available buses in this route",
                        style: Theme.of(context).textTheme.titleMedium)),
                busesInMyroute.length == 0
                    ? Container(
                        decoration: const BoxDecoration(),
                        margin: EdgeInsets.only(top: 100),
                        child: Image.asset(
                          'assets/icons/art2.png',
                          height: 200,
                        ),
                      )
                    : Container(),
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
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
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
                  "Current Location: " + model.busCurrentLocation,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusDetailsPage(model)));

                context.read<PayementProvider>().setBusId(model.busId);
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
