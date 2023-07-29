import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:words_app/core/network/end_points.dart';
import 'package:words_app/features/word_detail/data/usecases/local_load_word_impl.dart';
import 'package:words_app/features/word_detail/data/usecases/local_set_word_favorite.dart';
import 'package:words_app/features/word_detail/data/usecases/remote_load_word_impl.dart';
import 'package:words_app/features/word_detail/data/usecases/remote_load_word_with_local_fallback.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';
import 'package:words_app/features/word_detail/domain/usecases/set_word_favorite.dart';
import 'package:words_app/features/words/data/usecases/load_words_impl.dart';
import 'package:words_app/features/word_detail/data/usecases/local_save_word_history_impl.dart';
import 'package:words_app/features/words/domain/usecases/load_words.dart';
import 'package:words_app/features/word_detail/domain/usecases/save_word_history.dart';

import 'infra/cache/local_storage_adapter.dart';
import 'infra/http/http_adapter.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory<LoadWord>(
    () => RemoteLoadWordWithLocalFallback(
      remote: RemoteLoadWordImpl(
        httpClient: HttpAdapter(Client()),
        url: EndPoints.words,
      ),
      local: LocalLoadWordImpl(cacheStorage: localStorage),
    ),
  );
  getIt.registerFactory<LoadWords>(() => LoadWordsImpl());
  getIt.registerFactory<SaveWordHistory>(
      () => LocalSaveWordHistoryImpl(cacheStorage: localStorage));
  getIt.registerFactory<SetWordFavorite>(
      () => LocalSetWordFavorite(cacheStorage: localStorage));
  getIt.registerFactory(() => Client());
}

final localStorage =
    LocalStorageAdapter(localStorage: LocalStorage('wordsApp'));
