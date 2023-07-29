import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/widgets/default_error_view.dart';
import 'package:words_app/core/widgets/default_loading_view.dart';
import 'package:words_app/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:words_app/features/favorites/presentation/bloc/favorites_cubit_state.dart';
import 'package:words_app/features/favorites/presentation/screens/favorites_viewmodel.dart';

import '../screens/favorites_screen.dart';

class FavoritesContainer
    extends BlocBuilder<FavoritesCubit, FavoritesCubitState> {
  static const String routeName = '/word_detail';

  FavoritesContainer({super.key})
      : super(
          builder: (context, state) {
            switch (state.status) {
              case FavoritesStateStatus.loading:
                return const DefaultLoadingView();
              case FavoritesStateStatus.loaded:
                return FavoritesScreen(
                  viewModel: FavoritesViewModel(
                    words: state.favorites.map((e) => e.word).toList(),
                  ),
                );
              case FavoritesStateStatus.error:
                return DefaultErrorView(
                  message: state.error!,
                  onTryAgain: FavoritesCubitProvider.of(context).onInit,
                );
            }
          },
        );
}
