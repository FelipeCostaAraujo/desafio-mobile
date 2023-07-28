import '../../domain/entities/word_entity.dart';
import './remote_pronunciation_model.dart';
import './remote_results_model.dart';
import './remote_syllables_model.dart';

class RemoteWordModel {
  final String? word;
  final List<RemoteResultsModel>? results;
  final RemoteSyllablesModel? syllables;
  final RemotePronunciationModel? pronunciation;
  final double? frequency;

  const RemoteWordModel({
    this.word,
    this.results,
    this.syllables,
    this.pronunciation,
    this.frequency,
  });

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'results': results?.map((e) => e.toJson()).toList(),
      'syllables': syllables?.toJson(),
      'pronunciation': pronunciation?.toJson(),
      'frequency': frequency,
    };
  }

  factory RemoteWordModel.fromJson(Map<String, dynamic> json) {
    if (json['pronunciation'] is String) {
      json['pronunciation'] = {
        'all': json['pronunciation'],
      };
    }
    return RemoteWordModel(
      word: json['word'],
      results: json['results'] != null
          ? (json['results'] as List)
              .map((e) => RemoteResultsModel.fromJson(e))
              .toList()
          : null,
      syllables: json['syllables'] != null
          ? RemoteSyllablesModel.fromJson(json['syllables'])
          : null,
      pronunciation: json['pronunciation'] != null
          ? RemotePronunciationModel.fromJson(json['pronunciation'])
          : null,
      frequency: json['frequency']?.toDouble(),
    );
  }

  WordEntity toEntity() => WordEntity(
        word: word ?? "",
        definition: results?.first.definition ?? "",
        partOfSpeech: results?.first.partOfSpeech ?? "",
        synonyms: results?.first.synonyms ?? [],
        typeOf: results?.first.typeOf ?? [],
        hasTypes: results?.first.hasTypes ?? [],
        derivation: results?.first.derivation ?? [],
        examples: results?.first.examples ?? [],
        pronunciation: pronunciation?.all ?? "",
      );
}
