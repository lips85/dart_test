typedef Term = String;
typedef Definition = String;
typedef TermDefinitionMap = Map<Term, Definition>;
typedef TermDefinitionList = List<TermDefinitionMap>;

class Dictionary {
  // Internal storage for the dictionary
  TermDefinitionMap _words = {};

  // add: 단어를 추가함.
  void add(Term term, Definition definition) {
    _words[term] = definition;
  }

  // get: 단어의 정의를 리턴함.
  Definition? get(Term term) {
    return _words[term];
  }

  // delete: 단어를 삭제함.
  void delete(Term term) {
    _words.remove(term);
  }

  // update: 단어를 업데이트 함.
  void update(Term term, Definition definition) {
    if (exists(term)) {
      add(term, definition);
    } else {
      print("The term '$term' does not exist in the dictionary.");
    }
  }

  // showAll: 사전 단어를 모두 보여줌.
  void showAll() {
    _words.forEach((term, definition) {
      print('$term: $definition');
    });
  }

  // count: 사전 단어들의 총 갯수를 리턴함.
  int count() {
    return _words.length;
  }

  // upsert 단어를 업데이트 함. 존재하지 않을시. 이를 추가함. (update + insert = upsert)
  void upsert(Term term, Definition definition) {
    add(term, definition);
  }

  // exists: 해당 단어가 사전에 존재하는지 여부를 알려줌.
  bool exists(Term term) {
    return _words.containsKey(term);
  }

  // bulkAdd: 여러개의 단어를 한번에 추가할 수 있게 해줌. [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]
  void bulkAdd(TermDefinitionList terms) {
    for (var term in terms) {
      add(term['term']!, term['definition']!);
    }
  }

  // bulkDelete: 여러개의 단어를 한번에 삭제할 수 있게 해줌. ["김치", "아파트"]
  void bulkDelete(List<Term> terms) {
    for (var term in terms) {
      delete(term);
    }
  }
}

void main() {
  // Example usage
  Dictionary dictionary = Dictionary();

  // Adding words
  dictionary.add('김치', '대박이네~');
  dictionary.add('아파트', '비싸네~');

  // Getting a word's definition
  var definition = dictionary.get('김치');
  print(definition == '대박이네~'
      ? 'PASS: 김치의 정의가 올바르게 반환됨'
      : 'FAIL: 김치의 정의가 잘못 반환됨'); // Expected Output: 대박이네~

  // Updating a word's definition
  dictionary.update('김치', '정말 대박이네~');
  definition = dictionary.get('김치');
  print(definition == '정말 대박이네~'
      ? 'PASS: 김치의 정의가 올바르게 업데이트됨'
      : 'FAIL: 김치의 정의 업데이트 실패'); // Expected Output: 정말 대박이네~

  // Showing all words
  print('모든 단어와 정의:');
  dictionary.showAll(); // Expected Output: 김치: 정말 대박이네~, 아파트: 비싸네~

  // Counting words
  var count = dictionary.count();
  print(count == 2
      ? 'PASS: 단어의 총 갯수가 올바르게 반환됨'
      : 'FAIL: 단어의 총 갯수가 잘못 반환됨'); // Expected Output: 2

  // Upserting a word
  dictionary.upsert('사과', '맛있네~');
  dictionary.upsert('아파트', '정말 비싸네~');
  print('단어 추가 후 모든 단어와 정의:');
  dictionary.showAll(); // Expected Output: 김치: 정말 대박이네~, 아파트: 정말 비싸네~, 사과: 맛있네~

  // Checking if a word exists
  var exists = dictionary.exists('아파트');
  print(exists
      ? 'PASS: 아파트가 존재함'
      : 'FAIL: 아파트가 존재하지 않음'); // Expected Output: true
  exists = dictionary.exists('포도');
  print(!exists
      ? 'PASS: 포도가 존재하지 않음'
      : 'FAIL: 포도가 존재함'); // Expected Output: false

  // Bulk adding words
  dictionary.bulkAdd([
    {'term': '포도', 'definition': '달콤하네~'},
    {'term': '바나나', 'definition': '노랗네~'}
  ]);
  print('대량 추가 후 모든 단어와 정의:');
  dictionary
      .showAll(); // Expected Output: 김치: 정말 대박이네~, 아파트: 정말 비싸네~, 사과: 맛있네~, 포도: 달콤하네~, 바나나: 노랗네~

  // Bulk deleting words
  dictionary.bulkDelete(['김치', '바나나']);
  print('대량 삭제 후 모든 단어와 정의:');
  dictionary.showAll(); // Expected Output: 아파트: 정말 비싸네~, 사과: 맛있네~, 포도: 달콤하네~
}
