import 'package:bustracker/Pages/ApplySeniorCitizenshipCard.dart';
import 'package:bustracker/Pages/ApplyStCardd.dart';
import 'package:bustracker/Pages/ReportPage.dart';
import 'package:bustracker/Pages/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../Pages/Homepage.dart';
import '../Pages/LoginPage.dart';
import '../backend/SupabaseAuthentication.dart';
import 'SidebarNavBar.dart';


class DrawerContainer extends StatefulWidget {
  @override
  State<DrawerContainer> createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  int currentItem = 0;

  var pages = [Homepage(), SettingsPage(),ApplyStCard() ,ApplySeniorCitizenshipCard(),ReportPage(),Container()];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ZoomDrawer(
        style: DrawerStyle.defaultStyle,
        mainScreen: pages[currentItem],
        menuScreen: SidenavBar((item) {
          setState(() {
            this.currentItem = item;

            if (currentItem == 5) {
              SupabaseAuthentication().SignOut();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }
          });
        }),
      ),
    );
  }
}
