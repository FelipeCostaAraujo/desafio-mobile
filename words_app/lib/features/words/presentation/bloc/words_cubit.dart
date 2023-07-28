import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/words/domain/usecases/load_words.dart';
import 'package:words_app/features/words/presentation/bloc/words_cubit_state.dart';

class WordsCubit extends Cubit<WordsCubitState> {
  WordsCubit({
    required this.loadWords,
  }) : super(const WordsCubitState(status: WordsStateStatus.loading));

  LoadWords loadWords;

  void onInit() async {
    try {
      final wordsList = await loadWords.load();
      emit(state.copyWith(
        status: WordsStateStatus.loaded,
        words: wordsList,
      ));
    } on DomainError catch (error) {
      emit(state.copyWith(
        status: WordsStateStatus.error,
        error: error.description,
      ));
    }
  }
}

class WordsCubitProvider extends BlocProvider<WordsCubit> {
  WordsCubitProvider({
    Key? key,
    Widget? child,
  }) : super(
          key: key,
          create: (context) => WordsCubit(
            loadWords: GetIt.instance<LoadWords>(),
          )..onInit(),
          child: child,
        );

  static WordsCubit of(BuildContext context) =>
      BlocProvider.of<WordsCubit>(context);
}
