import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  double _objectifQuotidien = 3000.0;
  double _quantiteAAjouter = 300.0;
  double _fillLevel = 0.0;
  double _lastIncrementValue = 0.0;

  double get objectifQuotidien => _objectifQuotidien;
  double get quantiteAAjouter => _quantiteAAjouter;
  double get fillLevel => _fillLevel;
  double get lastIncrementValue => _lastIncrementValue;

  // Initialize Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SettingsModel() {
    // Load settings from Firestore when the model is created
    loadSettings();
  }

  void setObjectifQuotidien(double value) {
    _objectifQuotidien = value;
    notifyListeners();
    _saveSettings();
  }

  void setQuantiteAAjouter(double value) {
    _quantiteAAjouter = value;
    notifyListeners();
    _saveSettings();
  }

  void setFillLevel(double value) {
    _fillLevel = value;
    notifyListeners();
    _saveFillLevel();
  }

  void setLastIncrementValue(double value) {
    _lastIncrementValue = value;
    notifyListeners();
    _saveLastIncrementValue();
  }

  Future<void> _saveSettings() async {
    await _firestore.collection('Settings').doc('currentSettings').set({
      'objectifQuotidien': _objectifQuotidien,
      'quantiteAAjouter': _quantiteAAjouter,
    });
  }

  Future<void> _saveFillLevel() async {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    await _firestore.collection('Water').doc(formattedDate).set({
      'fillLevel': _fillLevel,
      'date': formattedDate,
    }, SetOptions(merge: true));
  }

  Future<void> _saveLastIncrementValue() async {
    await _firestore.collection('Settings').doc('currentSettings').update({
      'lastIncrementValue': _lastIncrementValue,
    });
  }

  Future<void> loadSettings() async {
    DocumentSnapshot doc = await _firestore.collection('Settings').doc('currentSettings').get();
    if (doc.exists) {
      _objectifQuotidien = doc['objectifQuotidien'];
      _quantiteAAjouter = doc['quantiteAAjouter'];
      _lastIncrementValue = doc['lastIncrementValue'];
      notifyListeners();
    }

    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    DocumentSnapshot waterDoc = await _firestore.collection('Water').doc(formattedDate).get();
    if (waterDoc.exists) {
      _fillLevel = waterDoc['fillLevel'];
      notifyListeners();
    }
  }
}
