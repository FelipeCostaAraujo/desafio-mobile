import 'package:flutter/material.dart';
import 'package:words_app/features/splash/splash_screen.dart';
import 'package:words_app/features/word_detail/presentation/bloc/word_cubit.dart';
import 'package:words_app/features/word_detail/presentation/containers/word_container.dart';

import 'features/home/presentation/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case WordContainer.routeName:
        if (args is WordArguments) {
          return MaterialPageRoute(
            builder: (_) => WordCubitProvider(
              arguments: args,
              child: WordContainer(),
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Erro de redirecionamento'),
        ),
      );
    });
  }
}

class WordArguments {
  final int index;
  final String word;
  final List<String> words;

  WordArguments({required this.index, required this.word, required this.words});
}
