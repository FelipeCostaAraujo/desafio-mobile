import 'package:mocktail/mocktail.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/word_detail/data/usecases/remote_load_word_impl.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

class RemoteLoadWordSpy extends Mock implements RemoteLoadWordImpl {
  When mockLoadCall() => when(() => load(any()));
  void mockLoad(WordEntity word) =>
      mockLoadCall().thenAnswer((_) async => word);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}