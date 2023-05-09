import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IconButton1 extends StatelessWidget {
  var icon;
  var ontap;
  IconButton1({this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: 30,
        decoration: const BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Icon(
          icon,
          size: 20,
        ),
      ),
    );
  }
}
