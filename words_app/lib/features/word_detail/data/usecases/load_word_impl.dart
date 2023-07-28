import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/core/http/http.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';

import '../models/remote_word_model.dart';

class LoadWordImpl implements LoadWord {
  final HttpClient httpClient;
  final String url;

  LoadWordImpl({required this.httpClient, required this.url});

  @override
  Future<WordEntity> load(String word) async {
    try {
      var httpResponse = await httpClient.request(url: "$url/$word", method: 'get');
      return RemoteWordModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (e) {
      switch (e) {
        case HttpError.notFound:
          throw DomainError.wordNotFound;
        case HttpError.forbidden:
          throw DomainError.serverError;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}
