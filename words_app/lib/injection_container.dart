import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:words_app/core/cache/cache.dart';
import 'package:words_app/core/http/http.dart';
import 'package:words_app/core/network/end_points.dart';
import 'package:words_app/features/favorites/data/usecases/local_load_favorites.dart';
import 'package:words_app/features/favorites/domain/usecases/load_favorites.dart';
import 'package:words_app/features/history/data/usecases/local_load_history.dart';
import 'package:words_app/features/history/domain/usecases/load_history.dart';
import 'package:words_app/features/word_detail/data/usecases/local_load_word_impl.dart';
import 'package:words_app/features/word_detail/data/usecases/local_set_word_favorite.dart';
import 'package:words_app/features/word_detail/data/usecases/remote_load_word_impl.dart';
import 'package:words_app/features/word_detail/data/composites/local_load_word_with_remote_fallback.dart';
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
  //Use cases
  getIt.registerLazySingleton<LoadHistory>(
      () => LocalLoadHistory(cacheStorage: getIt()));

  getIt.registerLazySingleton<LoadWords>(() => LoadWordsImpl());

  getIt.registerLazySingleton<SaveWordHistory>(
      () => LocalSaveWordHistoryImpl(cacheStorage: getIt()));
  getIt.registerLazySingleton<LoadFavorites>(
      () => LocalLoadFavorites(cacheStorage: getIt()));
  getIt.registerLazySingleton<SetWordFavorite>(
      () => LocalSetWordFavorite(cacheStorage: getIt()));

  //Compositors
  getIt.registerLazySingleton<LoadWord>(
    () => LocalLoadWordWithRemoteFallback(
      remote: RemoteLoadWordImpl(
        httpClient: getIt(),
        url: EndPoints.words,
      ),
      local: LocalLoadWordImpl(
        cacheStorage: getIt(),
      ),
    ),
  );

  //Data sources
  getIt.registerFactory<HttpClient>(() => HttpAdapter(Client()));

  getIt.registerFactory<CacheStorage>(
      () => LocalStorageAdapter(localStorage: LocalStorage('wordsApp')));
}
