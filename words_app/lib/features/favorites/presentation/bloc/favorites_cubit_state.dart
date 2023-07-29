import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

enum FavoritesStateStatus { loading, loaded, error }

class FavoritesCubitState {
  const FavoritesCubitState({
    required this.status,
    this.favorites = const [],
    this.error,
  });

  final FavoritesStateStatus status;
  final List<WordEntity> favorites;
  final String? error;

  FavoritesCubitState copyWith({
    FavoritesStateStatus? status,
    List<WordEntity>? favorites,
    String? error,
  }) {
    return FavoritesCubitState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      error: error ?? this.error,
    );
  }
}
