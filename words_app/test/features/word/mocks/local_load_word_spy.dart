import 'package:mocktail/mocktail.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/data/usecases/local_load_word_impl.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

class LocalLoadWordSpy extends Mock implements LocalLoadWordImpl {
  When mockLoadCall() => when(() => load(any()));
  void mockLoad(WordEntity word) =>
      mockLoadCall().thenAnswer((_) async => word);
  void mockLoadError() => mockLoadCall().thenThrow(DomainError.unexpected);
}