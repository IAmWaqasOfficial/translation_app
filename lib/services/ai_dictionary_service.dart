// lib/services/ai_dictionary_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class AiDictionaryService {

  static const String _apiKey = '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';


  static const String _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';

  // 🤖 Model name
  static const String _model = 'deepseek/deepseek-chat-v3-0324:free';

  /// 📚 Get definition, synonyms, and example for a given word
  static Future<Map<String, dynamic>> getWordData(String word) async {

    final prompt = '''
You are a dictionary assistant.
Return ONLY a valid JSON object, no extra text, no markdown, no explanations.
The JSON must have exactly these keys:
- definition (string)
- synonyms (array of strings)
- example (string)

Example:
{"definition": "A fruit that grows on apple trees.", "synonyms": ["fruit", "pome", "orchard fruit"], "example": "She ate a fresh apple from the garden."}

Word: $word
''';


    // 📡 Send POST request to AI API
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": _model,
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful AI dictionary."
          },
          {
            "role": "user",
            "content": prompt
          }
        ],
        "temperature": 0.2 // Lower temp = more consistent/accurate
      }),
    );


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Extract the AI's reply text
      final content = data['choices'][0]['message']['content'];

      try {
        // Second jsonDecode() turns string JSON → Dart Map
        return jsonDecode(content);
      } catch (e) {
        return {
          "definition": "Error: Could not parse AI response.",
          "synonyms": [],
          "example": ""
        };
      }
    } else {
      throw Exception('API error: ${response.body}');
    }
  }
}
