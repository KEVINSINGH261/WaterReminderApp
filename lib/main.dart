import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterreminderapp/pages/spalsh_screen.dart';
import 'package:waterreminderapp/pages/setting_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'notification_service.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    NotificationService notificationService = NotificationService();
    await notificationService.initNotifications();
    notificationService.showNotification(
      id: 0,
      title: 'Rappel de boire de l\'eau',
      body: 'N\'oubliez pas de boire de l\'eau régulièrement.',
    );
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  NotificationService notificationService = NotificationService();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const NavigationBarApp());
  await notificationService.initNotifications();

}
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


