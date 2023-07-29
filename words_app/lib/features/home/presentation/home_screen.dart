import 'package:flutter/material.dart';
import 'package:words_app/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:words_app/features/favorites/presentation/containers/favorites_container.dart';
import 'package:words_app/features/history/presentation/bloc/history_cubit.dart';
import 'package:words_app/features/history/presentation/containers/history_container.dart';
import 'package:words_app/features/words/presentation/bloc/words_cubit.dart';

import '../../../core/resources/i18n/resources.dart';
import '../../words/presentation/containers/words_container.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(child: Text(R.strings.wordsList)),
                    Tab(child: Text(R.strings.history)),
                    Tab(child: Text(R.strings.favorites))
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      WordsCubitProvider(child: WordsContainer()),
                      HistoryCubitProvider(child: HistoryContainer()),
                      FavoritesCubitProvider(child: FavoritesContainer()),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
