import 'package:flutter/material.dart';
import 'package:words_app/features/home/presentation/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _counter(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }

  _counter(context) async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
