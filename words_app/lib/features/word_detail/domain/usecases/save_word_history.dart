import '../entities/word_entity.dart';

abstract class SaveWordHistory {
  Future<void> save(WordEntity word);
}
