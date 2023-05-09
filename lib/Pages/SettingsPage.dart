


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatefulWidget
{
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(width: double.infinity,
          
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children:  [
              Text("Settings Page",style: Theme.of(context).textTheme.titleLarge,)
            ],),
          ),
          ),
        ),

      );
  }
}