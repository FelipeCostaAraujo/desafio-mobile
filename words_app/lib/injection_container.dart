import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:words_app/core/network/end_points.dart';
import 'package:words_app/features/word_detail/data/usecases/load_word_impl.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';
import 'package:words_app/features/words/data/usecases/load_words_impl.dart';
import 'package:words_app/features/words/domain/usecases/load_words.dart';

import 'infra/http/http_adapter.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory<LoadWord>(() =>
      LoadWordImpl(httpClient: HttpAdapter(Client()), url: EndPoints.words));
  getIt.registerFactory<LoadWords>(() => LoadWordsImpl());
  getIt.registerFactory(() => Client());
}
