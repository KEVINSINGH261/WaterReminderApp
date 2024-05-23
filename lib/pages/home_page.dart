import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _fillLevel = 0.0; // Niveau de remplissage initial
  double _maxValue = 3000.0; // Valeur maximale du remplissage
  double _incrementValue = 400.0; // Valeur d'incrémentation initiale

  final TextEditingController _maxValueController = TextEditingController();
  final TextEditingController _incrementValueController = TextEditingController();

  void _incrementFillLevel() {
    setState(() {
      _fillLevel += _incrementValue / _maxValue; // Ajoute la quantité spécifiée au remplissage
      if (_fillLevel > 1.0) {
        _fillLevel = 1.0; // Limite le niveau de remplissage à 100%
      }
    });
  }

  void _setMaxValue() {
    setState(() {
      _maxValue = double.tryParse(_maxValueController.text) ?? 100.0; // Met à jour la valeur maximale
      _fillLevel = 0.0; // Réinitialise le niveau de remplissage
    });
  }

  void _setIncrementValue() {
    setState(() {
      _incrementValue = double.tryParse(_incrementValueController.text) ?? 10.0; // Met à jour la valeur d'incrémentation
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(_fillLevel * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 50),
              ),
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
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(shape: CircleBorder(),
                padding: EdgeInsets.all(20)),
                onPressed: _incrementFillLevel,
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

