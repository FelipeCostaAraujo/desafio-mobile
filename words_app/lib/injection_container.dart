import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:words_app/features/words/data/usecases/load_words_impl.dart';
import 'package:words_app/features/words/domain/usecases/load_words.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory<LoadWords>(() => LoadWordsImpl());
  getIt.registerFactory(() => Client());
}
