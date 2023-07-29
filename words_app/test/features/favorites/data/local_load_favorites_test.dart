import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/favorites/data/usecases/local_load_favorites.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

import '../../word/domain/entity_factory.dart';
import '../../word/mocks/cache_storage_spy.dart';

void main() {
  late CacheStorageSpy cacheStorage;
  late LocalLoadFavorites sut;
  late List<Map<String, dynamic>> json;
  late List<WordEntity> words;

  setUp(() {
    json = [EntityFactory.makeWord().toJSon()];
    words = json.map((e) => WordEntity.fromJson(e)).toList();
    cacheStorage = CacheStorageSpy();
    sut = LocalLoadFavorites(cacheStorage: cacheStorage);
    cacheStorage.mockFetch(json);
  });

  test('Should call fetch with correct key', () async {
    await sut.load();

    verify(() => cacheStorage.fetch('favorites')).called(1);
  });

  test('Should return list of words if cacheStorage return list of json',
      () async {
    final result = await sut.load();

    expect(result, words);
  });

  test('Should throw UnexpectedError if cacheStorage throw Exception',
      () async {
    cacheStorage.mockFetchError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
