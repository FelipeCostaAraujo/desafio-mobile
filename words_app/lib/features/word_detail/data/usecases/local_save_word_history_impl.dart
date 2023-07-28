import 'package:words_app/features/word_detail/domain/usecases/save_word_history.dart';

import '../../../../core/cache/cache_storage.dart';
import '../../../../core/error/domain_errors.dart';

class LocalSaveWordHistoryImpl implements SaveWordHistory {
  final CacheStorage cacheStorage;

  LocalSaveWordHistoryImpl({required this.cacheStorage});

  @override
  Future<void> save(String word) async {
    try {
      if (word.isEmpty) {
        throw DomainError.unexpected;
      }
      List<String> words = await loadWordList();
      if (words.contains(word)) {
        words.remove(word);
      }
      words.insert(0, word);
      await cacheStorage.save(key: "history", value: words);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<List<String>> loadWordList() async {
    try {
      List<String> words = await cacheStorage.fetch('history');
      return words;
    } catch (error) {
      return [];
    }
  }
}
