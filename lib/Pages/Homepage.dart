import 'package:bustracker/Pages/LoginPage.dart';
import 'package:bustracker/Pages/NewRoutePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "BUS TRACKER",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: GestureDetector(
            onTap: () {
              ZoomDrawer.of(context)!.toggle();
            },
            child:const  Icon(Icons.menu)),
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
                      Text(
                        "My routes",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return MyRoutesCard();
                            }),
                      ),
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
                      Container(
                        height: 250,
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return MyTripCard();
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewRoutePage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Text(
                        "New Route",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
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

var myroutesList = [];

class MyRoutesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      margin: EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(10))),
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
            "Kundanoor to Kalamaserry",
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class MyTripCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 220,
        margin: EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 246, 232, 232),
            borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    "Kundanoor to Kalamaserry",
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
                  Text("Tuesday, 12:15 AM  - 12:50",
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
