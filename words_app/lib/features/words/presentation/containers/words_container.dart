import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/widgets/default_error_view.dart';
import 'package:words_app/core/widgets/default_loading_view.dart';
import 'package:words_app/features/words/presentation/bloc/words_cubit.dart';
import 'package:words_app/features/words/presentation/bloc/words_cubit_state.dart';
import 'package:words_app/features/words/presentation/screens/words_screen.dart';

class WordsContainer extends BlocBuilder<WordsCubit, WordsCubitState> {
  static String routeName = '/words';

  WordsContainer({super.key})
      : super(
          builder: (context, state) {
            switch (state.status) {
              case WordsStateStatus.loading:
                return const DefaultLoadingView();
              case WordsStateStatus.loaded:
                return WordsScreen(words: state.words);
              case WordsStateStatus.error:
                return DefaultErrorView(
                  onTryAgain: WordsCubitProvider.of(context).onInit,
                  message: state.error!,
                );
            }
          },
        );
}
