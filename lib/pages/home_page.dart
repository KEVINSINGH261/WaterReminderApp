import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterreminderapp/pages/setting_model.dart';
import 'package:waterreminderapp/pages/page_parametres.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _lastIncrementValue = 0.0;

  void _incrementFillLevel(double incrementValue, double maxValue, SettingsModel settings) {
    setState(() {
      _lastIncrementValue = incrementValue / maxValue;
      double newFillLevel = settings.fillLevel + _lastIncrementValue;
      if (newFillLevel > 1.0) {
        newFillLevel = 1.0;
      }
      settings.setFillLevel(newFillLevel); // Save the new fill level in the global state
    });
  }

  void _decrementFillLevel(SettingsModel settings) {
    setState(() {
      double newFillLevel = settings.fillLevel - _lastIncrementValue;
      if (newFillLevel < 0.0) {
        newFillLevel = 0.0;
      }
      settings.setFillLevel(newFillLevel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'images/img.png',
          width: 50.0,
          height: 50.0,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(settings.fillLevel * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 50),
              ),
              Text(
                '${settings.objectifQuotidien}',
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150.0,
                    height: 200.0,
                    decoration: BoxDecoration(),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 150.0,
                      height: 200.0 * settings.fillLevel,
                      color: Colors.blue,
                    ),
                  ),
                  Image.asset(
                    'images/logo_verre.png',
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: 180),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    onPressed: () => _incrementFillLevel(settings.quantiteAAjouter, settings.objectifQuotidien, settings),
                    child: Icon(Icons.add),
                  ),
                  SizedBox(width: 90),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                    ),
                    onPressed: () => _decrementFillLevel(settings),
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
