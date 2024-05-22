import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waterreminderapp/navigation_menu.dart';
import 'package:waterreminderapp/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const NavigationMenu()));
      });
    }

@override
void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);
}

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/img.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          )
      );
    }
}



