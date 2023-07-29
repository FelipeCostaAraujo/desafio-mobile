import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

abstract class LoadFavorites {
  Future<List<WordEntity>> load();
}