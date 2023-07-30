import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/data/composites/local_load_word_with_remote_fallback.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

import '../domain/entity_factory.dart';
import '../mocks/local_load_word_spy.dart';
import '../mocks/remote_load_word_spy.dart';

void main() {
  late LocalLoadWordWithRemoteFallback sut;
  late RemoteLoadWordSpy remote;
  late LocalLoadWordSpy local;
  late WordEntity remoteWord;
  late WordEntity localWord;
  late String word;

  setUp(() {
    word = faker.lorem.word();
    localWord = EntityFactory.makeWord();
    local = LocalLoadWordSpy();
    local.mockLoad(localWord);
    remoteWord = EntityFactory.makeWord();
    remote = RemoteLoadWordSpy();
    remote.mockLoad(remoteWord);
    sut = LocalLoadWordWithRemoteFallback(remote: remote, local: local);
  });

  setUpAll(() {
    registerFallbackValue(EntityFactory.makeWord());
  });

  test('Should call remote load', () async {
    local.mockLoadError();

    await sut.load(word);

    verify(() => remote.load(word)).called(1);
  });

  test('Should return remote word', () async {
    local.mockLoadError();

    final response = await sut.load(word);

    expect(response, remoteWord);
  });

  test('Should rethrow if remote load throws AccessDeniedError', () async {
    local.mockLoadError();
    remote.mockLoadError(DomainError.accessDenied);

    final future = sut.load(word);

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local load on remote error', () async {
    remote.mockLoadError(DomainError.unexpected);

    await sut.load(word);

    verify(() => local.load(word)).called(1);
  });

  test('Should return local word', () async {
    remote.mockLoadError(DomainError.unexpected);

    final response = await sut.load(word);

    expect(response, localWord);
  });

  test('Should throw UnexpectedError if remote and local load throws',
      () async {
    remote.mockLoadError(DomainError.unexpected);
    local.mockLoadError();

    final future = sut.load(word);

    expect(future, throwsA(DomainError.unexpected));
  });
}
