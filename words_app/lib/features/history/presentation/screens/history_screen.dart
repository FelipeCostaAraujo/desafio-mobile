import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/features/history/presentation/bloc/history_cubit.dart';
import 'package:words_app/router_generator.dart';
import '../../../../core/resources/i18n/resources.dart';
import '../../../word_detail/presentation/containers/word_container.dart';
import 'widgets/widgets.dart';
import 'history_viewmodel.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryViewModel viewModel;
  const HistoryScreen({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: viewModel.historyWords.isNotEmpty
            ? viewModel.historyWords
                .map(
                  (word) => HistoryListTile(
                    title: word,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(
                        WordContainer.routeName,
                        arguments: WordArguments(
                          index: viewModel.historyWords.indexOf(word),
                          word: word,
                          words: viewModel.historyWords,
                        ),
                      )
                          .then((result) {
                        context.read<HistoryCubit>().onInit();
                      });
                    },
                  ),
                )
                .toList()
            : [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text(R.strings.msgNoHistoryYet)),
                ),
              ],
      ),
    );
  }
}
