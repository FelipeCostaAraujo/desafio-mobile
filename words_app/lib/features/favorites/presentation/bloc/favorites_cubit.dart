import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/favorites/domain/usecases/load_favorites.dart';
import 'package:words_app/features/favorites/presentation/bloc/favorites_cubit_state.dart';

class FavoriteCubit extends Cubit<FavoritesCubitState> {
  FavoriteCubit({required this.loadFavorites})
      : super(const FavoritesCubitState(status: FavoritesStateStatus.loading));

  LoadFavorites loadFavorites;

  void onInit() async {
    try {
      var favoritesList = await loadFavorites.load();
      emit(state.copyWith(
        status: FavoritesStateStatus.loaded,
        favorites: favoritesList,
      ));
    } on DomainError catch (error) {
      emit(state.copyWith(
        status: FavoritesStateStatus.error,
        error: error.description,
      ));
    }
  }
}

class FavoriteCubitProvider extends BlocProvider<FavoriteCubit> {
  FavoriteCubitProvider({
    Key? key,
    Widget? child,
    required String word,
  }) : super(
          key: key,
          create: (_) => FavoriteCubit(
            loadFavorites: GetIt.instance<LoadFavorites>(),
          )..onInit(),
          child: child,
        );

  static FavoriteCubit of(BuildContext context) =>
      BlocProvider.of<FavoriteCubit>(context);
}
