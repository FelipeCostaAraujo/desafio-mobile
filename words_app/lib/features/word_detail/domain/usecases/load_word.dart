import '../entities/word_entity.dart';

abstract class LoadWord {
  Future<WordEntity> load(String word);
}