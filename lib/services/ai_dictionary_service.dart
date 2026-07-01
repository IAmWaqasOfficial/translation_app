import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:translation_app/models/dictionary_entry.dart';

class GeminiService1 {
  static Future<DictionaryEntry> getWordData(String word) async {
    final url = Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) throw Exception("No data found for the word '$word'");

        final entry = data.first;
        final meanings = entry['meanings'] as List<dynamic>;
        if (meanings.isEmpty) throw Exception("No meanings found for the word '$word'");

        final firstMeaning = meanings.first;
        final definitions = firstMeaning['definitions'] as List<dynamic>;
        if (definitions.isEmpty) throw Exception("No definitions found for the word '$word'");

        final def = definitions.first;

        return DictionaryEntry(
          word: entry['word'] ?? '',
          partOfSpeech: firstMeaning['partOfSpeech'] ?? "",
          definition: def['definition'] ?? "",
          example: def['example'] ?? "",
          synonyms: (def['synonyms'] as List<dynamic>?)?.cast<String>() ?? [],
        );
      } catch (e) {
        throw Exception("Failed to parse API response: $e");
      }
    } else {
      throw Exception("Word not found: ${response.body}");
    }
  }
}