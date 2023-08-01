import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:words_app/features/word_detail/presentation/containers/word_container.dart';
import 'package:words_app/router_generator.dart';
import '../../../../core/resources/i18n/resources.dart';
import './favorites_viewmodel.dart';
import './widgets/widgets.dart';

class FavoritesScreen extends StatefulWidget {
  final FavoritesViewModel viewModel;
  const FavoritesScreen({required this.viewModel, super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: widget.viewModel.words.isNotEmpty
            ? widget.viewModel.words
                .map((word) => FavoriteListTile(
                      title: word,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(WordContainer.routeName,
                                arguments: WordArguments(
                                  index: widget.viewModel.words.indexOf(word),
                                  word: word,
                                  words: widget.viewModel.words,
                                ))
                            .then((result) {
                          context.read<FavoritesCubit>().onInit();
                        });
                      },
                    ))
                .toList()
            : [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(R.strings.msgNoFavoritesYet),
                  ),
                )
              ],
      ),
    );
  }
}
