import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ajoutez cette ligne pour importer intl

class SettingsModel extends ChangeNotifier {
  double _objectifQuotidien = 3000.0;
  double _quantiteAAjouter = 300.0;
  double _lastIncrementValue = 0.0;
  double _eauQuotidienne = 0.0; // Nouvelle variable pour stocker la quantité d'eau quotidienne

  double get objectifQuotidien => _objectifQuotidien;
  double get quantiteAAjouter => _quantiteAAjouter;
  double get lastIncrementValue => _lastIncrementValue;
  double get eauQuotidienne => _eauQuotidienne; // Getter pour la quantité d'eau quotidienne

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

  void setLastIncrementValue(double value) {
    _lastIncrementValue = value;
    notifyListeners();
    _saveLastIncrementValue();
  }

  void setEauQuotidienne(double value) { // Ajout de la fonction setEauQuotidienne
    _eauQuotidienne = value;
    notifyListeners();
    _saveEauQuotidienne();
  }

  Future<void> _saveSettings() async {
    await _firestore.collection('Settings').doc('currentSettings').set({
      'objectifQuotidien': _objectifQuotidien,
      'quantiteAAjouter': _quantiteAAjouter,
    });
  }

  Future<void> _saveLastIncrementValue() async {
    await _firestore.collection('Settings').doc('currentSettings').update({
      'lastIncrementValue': _lastIncrementValue,
    });
  }

  Future<void> _saveEauQuotidienne() async { // Sauvegarder eauQuotidienne dans Firestore
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now); // Formatage de la date
    await _firestore.collection('Water').doc(formattedDate).set({
      'date': now, // Stocker la date
      'eauQuotidienne': _eauQuotidienne,
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

    // Chargement de la quantité d'eau quotidienne
    _loadEauQuotidienne();
  }

  Future<void> _loadEauQuotidienne() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now); // Formatage de la date
    DocumentSnapshot waterDoc = await _firestore.collection('Water').doc(formattedDate).get();
    if (waterDoc.exists) {
      _eauQuotidienne = waterDoc['eauQuotidienne'];
      notifyListeners();
    }
  }
}
