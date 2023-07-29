import 'package:flutter_test/flutter_test.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/data/usecases/local_save_word_history_impl.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

import '../domain/entity_factory.dart';
import '../mocks/cache_storage_spy.dart';

void main() {
  late LocalSaveWordHistoryImpl sut;
  late CacheStorageSpy cacheStorage;
  late WordEntity word;
  late List<WordEntity> words;
  late List<Map<String, dynamic>> json;

  setUp(() {
    words = [EntityFactory.makeWord()];
    json = words.map((e) => e.toJSon()).toList();
    word = EntityFactory.makeWord();
    cacheStorage = CacheStorageSpy();
    cacheStorage.mockFetch(json);
    sut = LocalSaveWordHistoryImpl(cacheStorage: cacheStorage);
  });

  test('Should completes if cache return null', () async {
    cacheStorage.mockFetch(null);

    final future = sut.save(word);

    expect(future, completes);
  });

  test('Should throw UnexpectedError if cache throw Exception', () async {
    cacheStorage.mockSaveError();

    final future = sut.save(word);

    expect(future, throwsA(DomainError.unexpected));
  });
}
