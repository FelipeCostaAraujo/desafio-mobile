import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'word_viewmodel.dart';
import 'widgets/widgets.dart';

enum TtsState { playing, stopped, paused, continued }

class WordScreen extends StatefulWidget {
  final WordViewModel word;
  const WordScreen({required this.word, super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  FlutterTts flutterTts = FlutterTts();
  double progress = 0;
  TtsState ttsState = TtsState.stopped;
  bool isFavorite = false;

  @override
  void initState() {
    initTts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WordHeadline(text: widget.word.word),
                  WordHeadline(text: widget.word.pronunciation),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _speech,
                  icon: ttsState == TtsState.playing
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                ),
                Expanded(
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end: progress,
                    ),
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      backgroundColor: Colors.grey[300],
                      color: Colors.red[300],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _setFavorite,
                  icon: isFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.word.definition.toCapitalize(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.word.example.toCapitalize(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(buttonLabel: "Previous", onPressed: () {}),
                  const SizedBox(width: 20),
                  CustomButton(buttonLabel: "Next", onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  _speech() async {
    if (ttsState == TtsState.playing) {
      await flutterTts.stop();
      setState(() => ttsState = TtsState.stopped);
    } else {
      var result = await flutterTts.speak(widget.word.word);
      progress = 1;
      if (result == 1) setState(() => ttsState = TtsState.playing);
    }
  }

  initTts() {
    flutterTts.setLanguage("en-US");

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
        progress = 0;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }
}

extension StringCasingExtension on String {
  String toCapitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
