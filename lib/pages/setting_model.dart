import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import '../notification_service.dart'; // Import notifications

class SettingsModel extends ChangeNotifier {
  double _objectifQuotidien = 3000.0;
  double _quantiteAAjouter = 300.0;
  double _lastIncrementValue = 0.0;
  double _eauQuotidienne = 0.0;
  int _intervalleNotif = 2; // Default interval for notifications
  bool _notificationsEnabled = false; // New boolean for notification state

  double get objectifQuotidien => _objectifQuotidien;
  double get quantiteAAjouter => _quantiteAAjouter;
  double get lastIncrementValue => _lastIncrementValue;
  double get eauQuotidienne => _eauQuotidienne;
  int get intervalleNotif => _intervalleNotif;
  bool get notificationsEnabled => _notificationsEnabled; // Getter for notification state

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationService _notificationService = NotificationService();

  SettingsModel() {
    loadSettings();
    _notificationService.initNotifications();
    _scheduleNotifications();
  }

  void setNotificationsEnabled(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
    _saveSettings();
    _savenotificationsEnabled();
    _scheduleNotifications();
  }

  void setIntervalleNotif(int value) {
    _intervalleNotif = value;
    notifyListeners();
    _saveSettings();
    _scheduleNotifications();
    _saveIntervalleNotif();
  }

  void setObjectifQuotidien(double value) {
    _objectifQuotidien = value;
    notifyListeners();
    _saveSettings();
    _saveObjectifQuotidien();

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

  void setEauQuotidienne(double value) {
    _eauQuotidienne = value;
    notifyListeners();
    _saveEauQuotidienne();
  }

  Future<void> _saveSettings() async {
    await _firestore.collection('Settings').doc('currentSettings').set({
      'objectifQuotidien': _objectifQuotidien,
      'quantiteAAjouter': _quantiteAAjouter,
      'intervalleNotif': _intervalleNotif,
      'notificationsEnabled': _notificationsEnabled, // Save notification state
    });
  }

  Future<void> _saveLastIncrementValue() async {
    await _firestore.collection('Settings').doc('currentSettings').update({
      'lastIncrementValue': _lastIncrementValue,
    });
  }

  Future<void> _saveObjectifQuotidien() async {
    await _firestore.collection('Settings').doc('currentSettings').update({
      'objectifQuotidien': _objectifQuotidien,
    });
  }

  Future<void> _saveEauQuotidienne() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    await _firestore.collection('Water').doc(formattedDate).set({
      'date': now,
      'eauQuotidienne': _eauQuotidienne,
    });
  }

  Future<void> _saveIntervalleNotif() async {
    await _firestore.collection('Settings').doc('currentSettings').update({
      'intervalleNotif': _intervalleNotif,
    });
  }

  Future<void> _savenotificationsEnabled() async {
    await _firestore.collection('Settings').doc('currentSettings').update({
      'notificationsEnabled': _notificationsEnabled,
    });
  }

  Future<void> loadSettings() async {
    DocumentSnapshot doc = await _firestore.collection('Settings').doc('currentSettings').get();
    if (doc.exists) {
      _objectifQuotidien = doc['objectifQuotidien'];
      _quantiteAAjouter = doc['quantiteAAjouter'];
      _lastIncrementValue = doc['lastIncrementValue'];
      _intervalleNotif = doc['intervalleNotif'];
      _notificationsEnabled = doc['notificationsEnabled']; // Load notification state
      notifyListeners();
      _scheduleNotifications();
    }

    _loadEauQuotidienne();
  }

  Future<void> _loadEauQuotidienne() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    DocumentSnapshot waterDoc = await _firestore.collection('Water').doc(formattedDate).get();
    if (waterDoc.exists) {
      _eauQuotidienne = waterDoc['eauQuotidienne'];
      notifyListeners();
    }
  }

  Future<void> _scheduleNotifications() async {
    if (_notificationsEnabled) {
      Workmanager().cancelAll();
      Workmanager().registerPeriodicTask(
        '1',
        'simplePeriodicTask',
        frequency: Duration(hours: _intervalleNotif),
      );
    } else {
      Workmanager().cancelAll();
    }
  }
}
