import 'package:words_app/core/cache/cache.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';

class LocalLoadWordImpl implements LoadWord {
  final CacheStorage cacheStorage;

  LocalLoadWordImpl({required this.cacheStorage});

  @override
  Future<WordEntity> load(String word) async {
    try {
      var json = await cacheStorage.fetch('history');
      List<WordEntity> words =
          json.map<WordEntity>((e) => WordEntity.fromJson(e)).toList();
      for (var item in words) {
        if (item.word == word) {
          return item;
        }
      }
      throw DomainError.wordNotFound;
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
