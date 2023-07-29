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
      var json = await cacheStorage.fetch('favorites');
      List<WordEntity> words =
          json.map<WordEntity>((e) => WordEntity.fromJson(e)).toList();
      return words;
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
