import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  double _objectifQuotidien = 3000.0;
  double _quantiteAAjouter = 300.0;
  double _fillLevel = 0.0;

  double get objectifQuotidien => _objectifQuotidien;
  double get quantiteAAjouter => _quantiteAAjouter;
  double get fillLevel => _fillLevel;

  void setObjectifQuotidien(double value) {
    _objectifQuotidien = value;
    notifyListeners();
  }

  void setQuantiteAAjouter(double value) {
    _quantiteAAjouter = value;
    notifyListeners();
  }

  void setFillLevel(double value) {
    _fillLevel = value;
    notifyListeners();
  }
}
