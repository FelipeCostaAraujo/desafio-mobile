import '../entities/word_entity.dart';

abstract class SetWordFavorite {
  Future<void> call(WordEntity word);
}
