import 'package:faker/faker.dart';

class ApiFactory {
  static Map makeWordJson() => {
        "word": faker.lorem.word(),
        "results": [
          {
            "definition": faker.lorem.words,
            "partOfSpeech": faker.lorem.word(),
            "synonyms": faker.lorem.sentences(2),
            "typeOf": faker.lorem.sentences(3),
            "hasTypes": faker.lorem.sentences(10),
          }
        ]
      };
}
