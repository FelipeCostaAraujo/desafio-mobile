import 'package:words_app/core/cache/cache.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';
import 'package:words_app/features/word_detail/domain/usecases/set_word_favorite.dart';

class LocalSetWordFavorite implements SetWordFavorite {
  final CacheStorage cacheStorage;

  LocalSetWordFavorite({required this.cacheStorage});

  @override
  Future<void> call(WordEntity word) async {
    try {
      List<WordEntity> words = await loadWordList();
      if (word.isFavorite) {
        words.insert(0, word);
        var encodableWords = words.map((e) => e.toJSon()).toList();
        cacheStorage.save(key: "favorites", value: encodableWords);
      } else {
        var isRemoved = words.remove(word);
        if (isRemoved) {
          var encodableWords = words.map((e) => e.toJSon()).toList();
          cacheStorage.save(key: "favorites", value: encodableWords);
        } else {
          throw DomainError.unexpected;
        }
      }
    } catch (e) {
      throw DomainError.unexpected;
    }
  }

  Future<List<WordEntity>> loadWordList() async {
    try {
      var json = await cacheStorage.fetch('favorites');

      List<WordEntity> words =
          json.map<WordEntity>((e) => WordEntity.fromJson(e)).toList();
      Set<WordEntity> setList = Set<WordEntity>.from(words);
      return List<WordEntity>.from(setList);
    } catch (error) {
      return [];
    }
  }
}
