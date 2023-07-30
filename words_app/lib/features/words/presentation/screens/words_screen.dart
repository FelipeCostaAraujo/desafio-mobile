import 'package:flutter/material.dart';
import 'package:words_app/features/word_detail/presentation/containers/word_container.dart';
import 'package:words_app/router_generator.dart';
import '../../../../core/resources/i18n/resources.dart';
import './widgets/widgets.dart';

class WordsScreen extends StatelessWidget {
  final List<String> words;
  const WordsScreen({required this.words, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              R.strings.wordsList,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: words.length,
              itemBuilder: (context, index) => WordCard(
                text: words[index],
                onTap: () {
                  Navigator.of(context).pushNamed(
                    WordContainer.routeName,
                    arguments: WordArguments(
                      index: index,
                      word: words[index],
                      words: words,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
