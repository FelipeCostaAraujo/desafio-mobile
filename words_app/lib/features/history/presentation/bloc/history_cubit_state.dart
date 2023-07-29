import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

enum HistoryCubitStateStatus { loading, loaded, error }

class HistoryCubitState {
  const HistoryCubitState({
    required this.status,
    this.history,
    this.error,
  });

  final HistoryCubitStateStatus status;
  final List<WordEntity>? history;
  final String? error;

  HistoryCubitState copyWith({
    HistoryCubitStateStatus? status,
    List<WordEntity>? history,
    String? error,
  }) {
    return HistoryCubitState(
      status: status ?? this.status,
      history: history ?? this.history,
      error: error ?? this.error,
    );
  }
}
