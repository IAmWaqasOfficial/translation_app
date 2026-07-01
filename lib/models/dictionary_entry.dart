class DictionaryEntry {
  final String word;
  final String partOfSpeech;
  final String definition;
  final String example;
  final List<String> synonyms;

  DictionaryEntry({
    required this.word,
    required this.partOfSpeech,
    required this.definition,
    required this.example,
    required this.synonyms,
  });

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) {
    return DictionaryEntry(
      word: json['word'] ?? '',
      partOfSpeech: json['partOfSpeech'] ?? '',
      definition: json['definition'] ?? '',
      example: json['example'] ?? '',
      synonyms: (json['synonyms'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }
}
