import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/history/domain/usecases/load_history.dart';
import 'package:words_app/features/history/presentation/bloc/history_cubit_state.dart';

class HistoryCubit extends Cubit<HistoryCubitState> {
  HistoryCubit({required this.loadHistory})
      : super(const HistoryCubitState(status: HistoryCubitStateStatus.loading));

  LoadHistory loadHistory;

  onInit() async {
    try {
      emit(state.copyWith(status: HistoryCubitStateStatus.loading));
      final history = await loadHistory.load();
      emit(state.copyWith(
        status: HistoryCubitStateStatus.loaded,
        history: history,
      ));
    } on DomainError catch (e) {
      emit(state.copyWith(
        status: HistoryCubitStateStatus.error,
        error: e.description,
      ));
    }
  }
}

class HistoryCubitProvider extends BlocProvider<HistoryCubit> {
  HistoryCubitProvider({
    Key? key,
    Widget? child,
  }) : super(
          key: key,
          create: (_) => HistoryCubit(
            loadHistory: GetIt.instance<LoadHistory>(),
          )..onInit(),
          child: child,
        );

  static HistoryCubit of(BuildContext context) =>
      BlocProvider.of<HistoryCubit>(context);
}
