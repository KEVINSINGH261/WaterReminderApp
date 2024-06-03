import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterreminderapp/pages/spalsh_screen.dart';
import 'package:waterreminderapp/pages/setting_model.dart';
void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsModel(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: SplashScreen(),
      ),
    );
  }
}


