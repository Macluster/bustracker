import 'package:flutter/material.dart';

import '../Models/MenuItems.dart';

class SidenavBar extends StatefulWidget {
  var GetSelectedItem;

  SidenavBar(this.GetSelectedItem);

  @override
  State<SidenavBar> createState() => _SidenavBarState();
}

class _SidenavBarState extends State<SidenavBar> {
  String getSelectedItem() {
    return selectedItem;
  }

  var selectedItem = "Home";
  var menuList = [
    MenuItem("Home", Icons.home),
    MenuItem("My Travels", Icons.bus_alert_outlined),
    MenuItem("Apply St Card", Icons.settings),
    MenuItem("Apply Senior Citizenship Card", Icons.people),
    MenuItem("Report", Icons.people),
    MenuItem("Sign Out", Icons.book)
  ];

  Widget buildMenuItem(MenuItem item, int index) => ListTile(
        onTap: () {
          setState(() {
            selectedItem = item.title;
          });
          widget.GetSelectedItem(index);
        },
        selected: selectedItem == item.title ? true : false,
        selectedTileColor: Color.fromARGB(255, 251, 226, 150),
        focusColor: Color.fromARGB(255, 247, 227, 167),
        hoverColor: Color.fromARGB(255, 247, 227, 167),
        leading: Icon(item.icon),
        title: Text(
          item.title,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              for (var v in menuList) buildMenuItem(v, menuList.indexOf(v))
            ],
          ),
        ),
      ),
    );
  }
}
