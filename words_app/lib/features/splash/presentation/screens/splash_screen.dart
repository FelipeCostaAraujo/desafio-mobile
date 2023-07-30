import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:words_app/features/home/presentation/home_screen.dart';
import 'package:words_app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:words_app/features/splash/presentation/bloc/splash_cubit_state.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashCubitState>(
        listener: (context, state) {
          if (state.status == SplashCubitStateStatus.authenticated) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
          if (state.status == SplashCubitStateStatus.unauthenticated) {
            Navigator.pushReplacementNamed(context, AuthScreen.routeName);
          }
        },
        builder: (context, state) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          );
        },
      ),
    );
  }
}
