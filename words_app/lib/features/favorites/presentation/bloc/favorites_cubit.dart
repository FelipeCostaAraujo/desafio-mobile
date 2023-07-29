import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/favorites/domain/usecases/load_favorites.dart';
import 'package:words_app/features/favorites/presentation/bloc/favorites_cubit_state.dart';

class FavoritesCubit extends Cubit<FavoritesCubitState> {
  FavoritesCubit({required this.loadFavorites})
      : super(const FavoritesCubitState(status: FavoritesStateStatus.loading));

  LoadFavorites loadFavorites;

  void onInit() async {
    try {
      emit(state.copyWith(status: FavoritesStateStatus.loading));
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

class FavoritesCubitProvider extends BlocProvider<FavoritesCubit> {
  FavoritesCubitProvider({
    Key? key,
    Widget? child,
  }) : super(
          key: key,
          create: (_) => FavoritesCubit(
            loadFavorites: GetIt.instance<LoadFavorites>(),
          )..onInit(),
          child: child,
        );

  static FavoritesCubit of(BuildContext context) =>
      BlocProvider.of<FavoritesCubit>(context);
}
