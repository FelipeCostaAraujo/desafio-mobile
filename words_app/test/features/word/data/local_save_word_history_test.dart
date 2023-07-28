import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/data/usecases/local_save_word_history_impl.dart';

import '../mocks/cache_storage_spy.dart';

void main(){
  late LocalSaveWordHistoryImpl sut;
  late CacheStorageSpy cacheStorage;
  late String word;
  late List<String> words;

  setUp((){
    words = faker.lorem.sentences(10);
    word = faker.lorem.word();
    cacheStorage = CacheStorageSpy();
    cacheStorage.mockFetch(words);
    sut = LocalSaveWordHistoryImpl(cacheStorage: cacheStorage);
  });

  test('Should call cacheStorage with correct key', () async {
    await sut.save(word);

    verify(() => cacheStorage.save(key: "history", value: words)).called(1);
  });

  test('Should throw UnexpectedError if word value is empty', () async {
    final future = sut.save("");

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache throw Exception', () async {
    cacheStorage.mockSaveError();

    final future = sut.save(word);

    expect(future, throwsA(DomainError.unexpected));
  });
}