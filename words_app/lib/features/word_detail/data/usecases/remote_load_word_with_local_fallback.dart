import 'package:words_app/features/word_detail/data/usecases/local_load_word_impl.dart';
import 'package:words_app/features/word_detail/data/usecases/remote_load_word_impl.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';
import 'package:words_app/features/word_detail/domain/usecases/load_word.dart';

class RemoteLoadWordWithLocalFallback implements LoadWord {
  final RemoteLoadWordImpl remote;
  final LocalLoadWordImpl local;

  RemoteLoadWordWithLocalFallback({
    required this.remote,
    required this.local,
  });

  @override
  Future<WordEntity> load(String word) async {
    try {
      final localWord = await local.load(word);
      return localWord;
    } catch (error) {
      return await remote.load(word);
    }
  }
}
