import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';
import 'package:words_app/features/word_detail/presentation/bloc/word_cubit_state.dart';

class WordCubit extends Cubit<WordCubitState> {
  WordCubit({required this.loadWord})
      : super(const WordCubitState(
          status: WordStateStatus.loading,
        ));

  LoadWord loadWord;

  void onInit(String word) async {
    try {
      final wordEntity = await loadWord.load(word);

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
          )..onInit(word),
          child: child,
        );

  static WordCubit of(BuildContext context) =>
      BlocProvider.of<WordCubit>(context);
}
