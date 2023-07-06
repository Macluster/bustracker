import 'package:bustracker/Components/DropDownList.dart';
import 'package:bustracker/Pages/BusDetailsPage.dart';
import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/backend/FirebaseDatabase.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:bustracker/backend/data.dart';
import 'package:bustracker/functions/ConvertSecondsToMinute.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../Providers/PaymentProvider.dart';

class NewRoutePage extends StatefulWidget {
  String currentBusStop = "";
  String destinationStop = "";
  NewRoutePage();
  NewRoutePage.data(
      {required this.currentBusStop, required this.destinationStop});
  @override
  State<NewRoutePage> createState() => _NewRoutePageState();
}

class _NewRoutePageState extends State<NewRoutePage> {
  String currentBusStop = "";
  String destinationStop = "";

  double screenHeight = 0.0;
  double screenWidth = 0.0;
  var myRoot = [];

  var rootDirection = 0; //0 means forward and 1 means backward
  List<BusModel> busesInMyroute = [];
  List<BusModel> FilteredBusesInMyRoute = [];
  int routeIndex = 0;
  DateTime? filterTime;
  var SearchedbusStops = [];

  Future<void> getRoute() async {
    setState(() {
      myRoot.clear();
    });
    var routes = await FirebaseDatabaseClass()
        .gerRouteIdAndBusStops(currentBusStop, destinationStop);
    print(routes);

    context.read<PayementProvider>().setfromBusStop(currentBusStop);
    context.read<PayementProvider>().setToBusStop(destinationStop);
    context
        .read<PayementProvider>()
        .setFare(routes['busStops'][routeIndex].length * 2 + 10);
        print("Ssss");
  
   
    setState(() {
      routeIndex = routes['routeIndex'];
      myRoot = routes['busStops'][0];
    });
    rootDirection = await FirebaseDatabaseClass()
        .getRootDirection(currentBusStop, destinationStop, routeIndex);
    setState(() {});
  }

  void filterData(TimeOfDay filterTime) {
    FilteredBusesInMyRoute.clear();
    FilteredBusesInMyRoute.addAll(busesInMyroute);

    List dummyList = [];
    dummyList.addAll(FilteredBusesInMyRoute);

    dummyList.forEach((element) {
      String timeleft = ConvertSecondstoMinute(
          (element.distanceLeft / (element.averageSpeed * 5 / 18)).round());
      TimeOfDay time = TimeOfDay(
          hour: int.parse(timeleft.split(":")[0]),
          minute: int.parse(timeleft.split(":")[0]));

      var filterDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, filterTime.hour, filterTime.minute);

      var busTimedate = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.now().hour,
          time.minute + DateTime.now().minute);

      print(filterDate);
      print(busTimedate);
      if (busTimedate.isBefore(filterDate)) {
        FilteredBusesInMyRoute.remove(element);
      }
    });

    setState(() {});
  }

  Future<void> getBusesInMyRoute() async {
    FilteredBusesInMyRoute.clear();
    busesInMyroute.clear();
    var buses = await SupaBaseDatabase()
        .getBusData(routeIndex, currentBusStop, rootDirection);

    for (int i = 0; i < buses.length; i++) {
      if (buses[i].busroute == routeIndex) {
        var d = await FirebaseDatabaseClass().getDistanceBwtTwoBusStop(
            currentBusStop,
            buses[i].busCurrentLocation,
            routeIndex,
            rootDirection);
        buses[i].distanceLeft = d;
        busesInMyroute.add(buses[i]);
      }
    }

    FilteredBusesInMyRoute.addAll(busesInMyroute);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    currentBusStop = widget.currentBusStop;
    destinationStop = widget.destinationStop;

    if (currentBusStop != "" && destinationStop != "") {
      init();
    }
    getBustops();
  }

  void getBustops() async {
    SearchedbusStops = await SupaBaseDatabase().getBusStopName();
    setState(() {});
  }

  void init() async {
    await getRoute();
    await getBusesInMyRoute();
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DropDownList(
                      SearchedbusStops, currentBusStop, "Current Bus stop",
                      (e) {
                    setState(() {
                      currentBusStop = e.toString();
                    });
                  }),
                  DropDownList(
                      SearchedbusStops, destinationStop, "Destination Bus stop",
                      (e) async {
                    setState(() {
                      destinationStop = e.toString();
                    });
                    await getRoute();
                    await getBusesInMyRoute();
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Available buses in this route",
                            style: Theme.of(context).textTheme.titleMedium),
                        GestureDetector(
                            onTap: () async {
                              TimeOfDay time = await showTimePicker(
                                      context: context,
                                      initialTime:
                                          TimeOfDay(hour: 5, minute: 0))
                                  as TimeOfDay;
                              filterData(time);
                            },
                            child: Icon(
                              Icons.filter_alt,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                  ),
                  busesInMyroute.length == 0
                      ? Container(
                          decoration: const BoxDecoration(),
                          margin: EdgeInsets.only(top: 100),
                          child: Lottie.asset(
                            'assets/lottie/a2.json',
                            height: 250,
                          ),
                        )
                      : Container(),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: FilteredBusesInMyRoute.length,
                        itemBuilder: (context, index) {
                          return BusCard(
                              FilteredBusesInMyRoute[index], UniqueKey());
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BusCard extends StatelessWidget {
  BusModel model;

  BusCard(this.model, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topLeft,
      height: 90,
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
                ),
                Text(
                  "Time for bus to reach: " +
                      ConvertSecondstoMinute(
                          (model.distanceLeft / (model.averageSpeed * 5 / 18))
                              .round()),
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
