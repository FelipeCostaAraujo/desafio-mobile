import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';
import 'package:words_app/features/word_detail/domain/usecases/save_word_history.dart';

import '../../../../core/cache/cache_storage.dart';
import '../../../../core/error/domain_errors.dart';

class LocalSaveWordHistoryImpl implements SaveWordHistory {
  final CacheStorage cacheStorage;

  LocalSaveWordHistoryImpl({required this.cacheStorage});

  @override
  Future<void> save(WordEntity word) async {
    try {
      List<WordEntity> words = await loadWordList();
      if (words.contains(word)) {
        words.remove(word);
      }
      words.insert(0, word);
      var encodableWords = words.map((e) => e.toJSon()).toList();
      await cacheStorage.save(key: "history", value: encodableWords);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<List<WordEntity>> loadWordList() async {
    try {
      var json = await cacheStorage.fetch('history');
      List<WordEntity> words =json.map<WordEntity>((e) => WordEntity.fromJson(e)).toList();
      return words;
    } catch (error) {
      return [];
    }
  }
}
