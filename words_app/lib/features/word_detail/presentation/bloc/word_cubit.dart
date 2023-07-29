import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';
import 'package:words_app/features/word_detail/domain/usecases/save_word_history.dart';
import 'package:words_app/features/word_detail/domain/usecases/set_word_favorite.dart';
import 'package:words_app/features/word_detail/presentation/bloc/word_cubit_state.dart';

import '../../domain/entities/word_entity.dart';

class WordCubit extends Cubit<WordCubitState> {
  WordCubit({
    required this.loadWord,
    required this.saveWordHistory,
    required this.setWordFavorite,
  }) : super(const WordCubitState(
          status: WordStateStatus.loading,
        ));

  LoadWord loadWord;
  SaveWordHistory saveWordHistory;
  SetWordFavorite setWordFavorite;
  late WordEntity wordEntity;

  void onInit(String word) async {
    try {
      wordEntity = await loadWord.load(word);
      saveWord(wordEntity);
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

  Future<void> saveWord(WordEntity word) async {
    try {
      await saveWordHistory.save(word);
    } on DomainError catch (error) {
      emit(state.copyWith(
        status: WordStateStatus.error,
        error: error.description,
      ));
    }
  }

  Future<void> setFavorite(bool isFavorite) async {
    try {
      final word = wordEntity.copyWith(isFavorite: isFavorite);
      emit(state.copyWith(word: word));
      await setWordFavorite(word);
      await Future.delayed(const Duration(seconds: 1));
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
            setWordFavorite: GetIt.instance<SetWordFavorite>(),
          )..onInit(word),
          child: child,
        );

  static WordCubit of(BuildContext context) =>
      BlocProvider.of<WordCubit>(context);
}
