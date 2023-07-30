import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';
import 'package:words_app/features/word_detail/domain/usecases/save_word_history.dart';
import 'package:words_app/features/word_detail/domain/usecases/set_word_favorite.dart';
import 'package:words_app/features/word_detail/presentation/bloc/word_cubit_state.dart';
import 'package:words_app/router_generator.dart';

import '../../domain/entities/word_entity.dart';

class WordCubit extends Cubit<WordCubitState> {
  WordCubit({
    required this.loadWord,
    required this.saveWordHistory,
    required this.setWordFavorite,
    required this.words,
    required this.wordPosition,
  }) : super(const WordCubitState(
          status: WordStateStatus.loading,
        ));

  LoadWord loadWord;
  SaveWordHistory saveWordHistory;
  SetWordFavorite setWordFavorite;
  List<String> words;
  int wordPosition;
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
      handleError(error);
    }
  }

  Future<void> saveWord(WordEntity word) async {
    try {
      await saveWordHistory.save(word);
    } on DomainError catch (error) {
      handleError(error);
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
      handleError(error);
    }
  }

  Future<void> previousWord() async {
    try {
      emit(state.copyWith(status: WordStateStatus.loading));
      if (wordPosition > 0) {
        wordPosition--;
        final word = await loadWord.load(words[wordPosition]);
        onInit(word.word);
      } else {
        final word = await loadWord.load(words[words.length - 1]);
        wordPosition = words.length - 1;
        onInit(word.word);
      }
    } on DomainError catch (error) {
      emit(state.copyWith(
        status: WordStateStatus.error,
        error: error.description,
      ));
    }
  }

  Future<void> nextWord() async {
    try {
      emit(state.copyWith(status: WordStateStatus.loading));
      if (wordPosition < words.length - 1) {
        wordPosition++;
        final word = await loadWord.load(words[wordPosition]);
        onInit(word.word);
      } else {
        final word = await loadWord.load(words[0]);
        wordPosition = 0;
        onInit(word.word);
      }
    } on DomainError catch (error) {
      handleError(error);
    }
  }

  void handleError(DomainError error) {
    emit(state.copyWith(
      status: WordStateStatus.error,
      error: error.description,
    ));
  }
}

class WordCubitProvider extends BlocProvider<WordCubit> {
  WordCubitProvider({
    Key? key,
    Widget? child,
    required WordArguments arguments,
  }) : super(
          key: key,
          create: (_) => WordCubit(
            loadWord: GetIt.instance<LoadWord>(),
            saveWordHistory: GetIt.instance<SaveWordHistory>(),
            setWordFavorite: GetIt.instance<SetWordFavorite>(),
            words: arguments.words,
            wordPosition: arguments.index,
          )..onInit(arguments.word),
          child: child,
        );

  static WordCubit of(BuildContext context) =>
      BlocProvider.of<WordCubit>(context);
}
