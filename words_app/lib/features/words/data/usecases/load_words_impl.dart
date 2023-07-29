import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/words/domain/usecases/load_words.dart';

class LoadWordsImpl implements LoadWords {
  @override
  Future<List<String>> load() async {
    try {
      var response =
          await rootBundle.loadString('assets/json/words_dictionary.json');
      await Future.delayed(const Duration(seconds: 2));
      var wordsJson = jsonDecode(response);
      return wordsJson.keys.toList();
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
