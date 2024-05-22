import 'package:flutter/material.dart';
import 'package:waterreminderapp/navigation_menu.dart';
import 'package:waterreminderapp/pages/home_page.dart';
import 'package:waterreminderapp/pages/spalsh_screen.dart';


void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: SplashScreen(),
    );
  }
}


