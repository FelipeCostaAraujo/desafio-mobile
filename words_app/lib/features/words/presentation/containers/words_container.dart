import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/features/words/presentation/bloc/words_cubit.dart';
import 'package:words_app/features/words/presentation/bloc/words_cubit_state.dart';
import 'package:words_app/features/words/presentation/screens/words_screen.dart';

class WordsContainer extends BlocBuilder<WordsCubit, WordsCubitState> {
  static String routeName = '/words';

  WordsContainer({super.key})
      : super(
          builder: (context, state) {
            switch(state.status){
              case WordsStateStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WordsStateStatus.loaded:
                return WordsScreen(words: state.words);
              case WordsStateStatus.error:
                return Center(
                  child: Text(state.error ?? 'Error'),
                );
            }
          },
        );
}
