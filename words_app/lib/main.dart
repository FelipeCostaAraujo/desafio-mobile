import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'router_generator.dart';
import 'injection_container.dart' as ic;

void main() async {
  ic.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  T? cast<T>(x) => x is T ? x : null;

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
