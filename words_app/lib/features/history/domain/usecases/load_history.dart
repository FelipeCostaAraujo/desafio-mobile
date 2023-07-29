import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

abstract class LoadHistory {
  Future<List<WordEntity>> load();
}
