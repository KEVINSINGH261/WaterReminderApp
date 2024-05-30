import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _fillLevel = 0.0;
  double _maxValue = 3000.0;
  double _incrementValue = 300.0;
  double _lastIncrementValue = 0.0;

  final TextEditingController _maxValueController = TextEditingController();
  final TextEditingController _incrementValueController = TextEditingController();

  void _incrementFillLevel() {
    setState(() {
      _lastIncrementValue = _incrementValue / _maxValue;
      _fillLevel += _lastIncrementValue;
      if (_fillLevel > 1.0) {
        _fillLevel = 1.0;
      }
    });
  }

  void _decrementFillLevel() {
    setState(() {
      _fillLevel -= _lastIncrementValue;
      if (_fillLevel < 0.0) {
        _fillLevel = 0.0;
      }
    });
  }

  void _setMaxValue() {
    setState(() {
      _maxValue = double.tryParse(_maxValueController.text) ?? 100.0;
      _fillLevel = 0.0;
    });
  }

  void _setIncrementValue() {
    setState(() {
      _incrementValue = double.tryParse(_incrementValueController.text) ?? 10.0;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                '${(_fillLevel * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center, // Centrer les éléments dans le Stack
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
                      height: 200.0 * _fillLevel,
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
                children: [
                      SizedBox(width: 174,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                      onPressed: _incrementFillLevel,
                      child: Icon(Icons.add),
                    ),
                    SizedBox(width: 90,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),
                      ),
                      onPressed: _decrementFillLevel,
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

