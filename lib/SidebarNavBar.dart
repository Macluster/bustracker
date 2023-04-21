import 'package:flutter/material.dart';

class SidenavBar extends StatelessWidget {
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
              MenuItem("Settings", Icons.settings),
              const SizedBox(
                height: 20,
              ),
              MenuItem("Profile", Icons.person),
              const SizedBox(
                height: 20,
              ),
              MenuItem("Apply St Card", Icons.school),
              const SizedBox(
                height: 20,
              ),
              MenuItem("Apply Other", Icons.book)
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  String text;
  IconData icon;

  MenuItem(this.text, this.icon);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedTileColor: Color.fromARGB(255, 251, 226, 150),
      focusColor: Color.fromARGB(255, 247, 227, 167),
      hoverColor: Color.fromARGB(255, 247, 227, 167),
      leading: Icon(icon),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
