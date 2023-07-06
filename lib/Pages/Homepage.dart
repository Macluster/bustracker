import 'package:bustracker/Components/Button1.dart';
import 'package:bustracker/Components/Button2.dart';
import 'package:bustracker/Components/ShimmerList.dart';
import 'package:bustracker/Models/MyRouteModel.dart';
import 'package:bustracker/Models/PaymentModel.dart';
import 'package:bustracker/Pages/LoginPage.dart';
import 'package:bustracker/Pages/NewRoutePage.dart';
import 'package:bustracker/Providers/UserProvider.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../Components/DropDownList.dart';
import '../Components/IconButton1.dart';
import '../backend/data.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<MyRouteModel> myRouteslist = [];
  String currentBusStop = "";
  String destinationStop = "";
  var SearchedbusStops = [];
  getMyRoutes() async {
    // myRouteslist = await SupaBaseDatabase().getMyroutes();
    setState(() {});
  }

 void getBustops() async {
    SearchedbusStops = await SupaBaseDatabase().getBusStopName();
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    //getMyRoutes();
    super.initState();
    getBustops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 0,
        title: Text(
          "BUS TRACKER",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: GestureDetector(
            onTap: () {
              ZoomDrawer.of(context)!.toggle();
            },
            child: const Icon(Icons.menu)),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "My routes",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          IconButton1(
                            icon: Icons.edit,
                            ontap: () {
                              DialogeBox();
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<UserProvider>(builder: (context, data, child) {
                        return StreamBuilder(
                            stream: SupaBaseDatabase().GetMyRouteStream(data.getUserId()),
                            builder: (context, AsyncSnapshot snap) {
                              if (snap.hasData) {
                                List data = SupaBaseDatabase().getMyroutesModelList(snap.data);
                                return Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return MyRoutesCard(data[index]);
                                      }),
                                );
                              } else {
                                return ShimmerList(height: 180, width: 120,axis: Axis.horizontal,ContainerHeight: 150,);
                              }
                            });
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Recent Travels",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: SupaBaseDatabase().getHistory(),
                          builder: (context, AsyncSnapshot<List<PayementModel>> snap) {
                            if (snap.hasData) {
                              return Container(
                                height: 450,
                                width: double.infinity,
                                child: ListView.builder(
                                    itemCount: snap.data!.length,
                                    itemBuilder: (context, index) {
                                      return MyTripCard(snap.data![index]);
                                    }),
                              );
                            } else {
                              return ShimmerList(height: 100, width: double.infinity, axis: Axis.vertical,ContainerHeight: 300,);
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Button1("New Route", () {
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewRoutePage()));
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DialogeBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Add Route",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    DropDownList(SearchedbusStops, currentBusStop, "Current Bus stop", (e) {
                      currentBusStop = e.toString();
                      setState(() {});
                    }),
                    DropDownList(SearchedbusStops, destinationStop, "Destination Bus stop", (e) async {
                      setState(() {
                        destinationStop = e.toString();
                      });
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                    Button2("Submit", () async {
                      await SupaBaseDatabase().AddMyRoute(currentBusStop, destinationStop);
                    })
                  ],
                ),
              ),
            ],
          );
        });
  }
}

var myroutesList = [];

class MyRoutesCard extends StatelessWidget {
  MyRouteModel model;
  MyRoutesCard(this.model);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>NewRoutePage.data(currentBusStop: model.sartingStopName,destinationStop: model.destinationStopName)));
      },
      child: Container(
        height: 50,
        width: 120,
        margin: EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_city,
              size: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              model.sartingStopName,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            Icon(Icons.arrow_downward),
            Text(
              model.destinationStopName,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            )
          ],
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
    );
  }
}
