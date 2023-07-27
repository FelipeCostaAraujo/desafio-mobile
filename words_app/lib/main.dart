import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'firebase_options.dart';
import 'router_generator.dart';
import 'injection_container.dart' as ic;

void main() async {
  ic.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseRemoteConfig.instance.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 3),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const routes = RouteGenerator.generateRoute;
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      title: 'Desafio Pilar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: routes,
      navigatorKey: navigatorKey,
    );
  }
}
