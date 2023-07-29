import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/widgets/default_error_view.dart';
import 'package:words_app/core/widgets/default_loading_view.dart';
import 'package:words_app/features/history/presentation/bloc/history_cubit.dart';
import 'package:words_app/features/history/presentation/bloc/history_cubit_state.dart';
import 'package:words_app/features/history/presentation/screens/history_screen.dart';
import 'package:words_app/features/history/presentation/screens/history_viewmodel.dart';

class HistoryContainer extends BlocBuilder<HistoryCubit, HistoryCubitState> {
  static const String routeName = '/word_detail';

  HistoryContainer({super.key})
      : super(
          builder: (context, state) {
            switch (state.status) {
              case HistoryCubitStateStatus.loading:
                return const DefaultLoadingView();
              case HistoryCubitStateStatus.loaded:
                return HistoryScreen(
                  viewModel: HistoryViewModel(
                    historyWords: state.history!.map((e) => e.word).toList(),
                  ),
                );
              case HistoryCubitStateStatus.error:
                return DefaultErrorView(
                  message: state.error!,
                  onTryAgain: HistoryCubitProvider.of(context).onInit,
                );
            }
          },
        );
}
