import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/widgets/default_error_view.dart';
import 'package:words_app/core/widgets/default_loading_view.dart';
import 'package:words_app/features/word_detail/presentation/bloc/word_cubit.dart';
import 'package:words_app/features/word_detail/presentation/bloc/word_cubit_state.dart';
import 'package:words_app/features/word_detail/presentation/screens/word_viewmodel.dart';

import '../screens/word_screen.dart';

class WordContainer extends BlocBuilder<WordCubit, WordCubitState> {
  static const String routeName = '/word_detail';

  WordContainer({super.key})
      : super(
          builder: (context, state) {
            switch (state.status) {
              case WordStateStatus.loading:
                return const DefaultLoadingView();
              case WordStateStatus.loaded:
                return WordScreen(
                  word: WordViewModel(
                    word: state.word!.word,
                    isFavorite: state.word?.isFavorite ?? false,
                    definition: state.word!.definition,
                    example: state.word!.examples.isNotEmpty
                        ? state.word!.examples.first
                        : "",
                    pronunciation: state.word!.pronunciation,
                  ),
                );
              case WordStateStatus.error:
                return DefaultErrorView(
                  message: "Word not found",
                  buttonLabel: "Back",
                  onTryAgain: () => Navigator.pop(context),
                );
            }
          },
        );
}
