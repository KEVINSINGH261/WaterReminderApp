import 'package:flutter/material.dart';
import 'package:waterreminderapp/pages/home_page.dart';
import 'package:waterreminderapp/pages/page_parametres.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Historique',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.water_drop),
            icon: Icon(Icons.water_drop_outlined),
            label: 'Acuueil',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Paramètres',
          ),
        ],
      ),
      body: <Widget>[
       Container(
         color: Colors.blueAccent,
       ),
        HomePage(),
        PageParametres()
      ][currentPageIndex],
    );
  }
}