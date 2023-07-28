import 'package:faker/faker.dart';

class ApiFactory {
  static Map<String, dynamic> makeWordJson() => {
        "word": faker.lorem.word(),
        "results": [
          {
            "definition": faker.lorem.word(),
            "partOfSpeech": faker.lorem.word(),
            "synonyms": faker.lorem.sentences(5),
            "typeOf": faker.lorem.sentences(3),
          }
        ],
        "pronunciation": {"all": faker.lorem.word()}
      };
}
