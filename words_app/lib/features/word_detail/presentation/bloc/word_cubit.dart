import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';
import 'package:words_app/features/word_detail/domain/usecases/save_word_history.dart';
import 'package:words_app/features/word_detail/presentation/bloc/word_cubit_state.dart';

class WordCubit extends Cubit<WordCubitState> {
  WordCubit({required this.loadWord, required this.saveWordHistory})
      : super(const WordCubitState(
          status: WordStateStatus.loading,
        ));

  LoadWord loadWord;
  SaveWordHistory saveWordHistory;

  void onInit(String word) async {
    try {
      final wordEntity = await loadWord.load(word);
      saveWord(wordEntity.word);
      emit(state.copyWith(
        status: WordStateStatus.loaded,
        word: wordEntity,
      ));
    } on DomainError catch (error) {
      emit(
        state.copyWith(
          status: WordStateStatus.error,
          error: error.description,
        ),
      );
    }
  }

  Future<void> saveWord(String word) async {
    try {
      await saveWordHistory.save(word);
    } on DomainError catch (error) {
      emit(state.copyWith(
        status: WordStateStatus.error,
        error: error.description,
      ));
    }
  }
}

class WordCubitProvider extends BlocProvider<WordCubit> {
  WordCubitProvider({
    Key? key,
    Widget? child,
    required String word,
  }) : super(
          key: key,
          create: (_) => WordCubit(
            loadWord: GetIt.instance<LoadWord>(),
            saveWordHistory: GetIt.instance<SaveWordHistory>(),
          )..onInit(word),
          child: child,
        );

  static WordCubit of(BuildContext context) =>
      BlocProvider.of<WordCubit>(context);
}
