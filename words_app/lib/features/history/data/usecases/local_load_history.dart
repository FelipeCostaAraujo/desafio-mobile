import 'package:words_app/features/history/domain/usecases/load_history.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

import '../../../../core/cache/cache_storage.dart';
import '../../../../core/error/domain_errors.dart';

class LocalLoadHistory implements LoadHistory {
  final CacheStorage cacheStorage;

  LocalLoadHistory({required this.cacheStorage});

  @override
  Future<List<WordEntity>> load() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      var json = await cacheStorage.fetch('history');
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
