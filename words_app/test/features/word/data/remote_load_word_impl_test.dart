import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/core/http/http_error.dart';
import 'package:words_app/features/word_detail/data/usecases/remote_load_word_impl.dart';

import '../../../infra/mocks/mocks.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/http_client_spy.dart';

void main() {
  late RemoteLoadWordImpl sut;
  late HttpClientSpy httpClient;
  late String url;
  late String word;
  late Map response;

  setUp(() {
    response = ApiFactory.makeWordJson();
    word = faker.lorem.word();
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    httpClient.mockRequest(response);
    sut = RemoteLoadWordImpl(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load(word);

    verify(() => httpClient.request(url: "$url/$word", method: 'get'))
        .called(1);
  });

  test('Should refresh return on 200', () async {
    final future = sut.load(word);

    expect(future, completes);
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = sut.load(word);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 401', () async {
    httpClient.mockRequestError(HttpError.unauthorized);

    final future = sut.load(word);

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final future = sut.load(word);

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should throw AccessDeniedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = sut.load(word);

    expect(future, throwsA(DomainError.wordNotFound));
  });
}
