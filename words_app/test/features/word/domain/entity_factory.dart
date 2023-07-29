import 'package:faker/faker.dart';
import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

class EntityFactory {
  static WordEntity makeWord() => WordEntity(
        word: faker.lorem.word(),
        definition: faker.lorem.word(),
        partOfSpeech: faker.lorem.word(),
        pronunciation: faker.lorem.word(),
        typeOf: faker.lorem.sentences(3),
        hasTypes: faker.lorem.sentences(3),
        derivation: faker.lorem.sentences(3),
        examples: faker.lorem.sentences(3),
        synonyms: faker.lorem.sentences(3),
      );
}
