import 'package:words_app/core/cache/cache.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/favorites/domain/usecases/load_favorites.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

class LocalLoadFavorites implements LoadFavorites {
  final CacheStorage cacheStorage;

  LocalLoadFavorites({required this.cacheStorage});

  @override
  Future<List<WordEntity>> load() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      var json = await cacheStorage.fetch('favorites');
      if (json == null) {
        return [];
      }
      List<WordEntity> words =
          json.map<WordEntity>((e) => WordEntity.fromJson(e)).toList();
      Set<WordEntity> setList = Set<WordEntity>.from(words);
      return List<WordEntity>.from(setList);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
