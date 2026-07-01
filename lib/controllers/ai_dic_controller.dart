import 'package:translation_app/services/ai_dictionary_service.dart';
import 'package:translation_app/models/dictionary_entry.dart';

class AiDictionaryController {
  String definition = '';
  List<String> synonyms = [];
  String example = '';
  bool isLoading = false;

  Future<void> searchWord(String word) async {
    word = word.trim();
    print("🔍 Searching word: $word");

    if (word.isEmpty) {
      print("⚠️ Word is empty");
      return;
    }

    definition = '';
    synonyms = [];
    example = '';
    isLoading = true;
    print("⏳ Starting search, isLoading = $isLoading");

    try {
      final DictionaryEntry entry = await GeminiService1.getWordData(word);
      print("✅ AI response received: ${entry.word}");

      definition = entry.definition;
      synonyms = entry.synonyms;
      example = entry.example;

      print("📖 Parsed definition: $definition");
      print("🔗 Parsed synonyms: $synonyms");
      print("💡 Parsed example: $example");
    } catch (e) {
      definition = 'Error: $e';
      synonyms = [];
      example = '';
      print("❌ Error occurred: $e");
    } finally {
      isLoading = false;
      print("⏹ Search finished, isLoading = $isLoading");
    }
  }
}