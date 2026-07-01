import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String _apiKey = 'AIzaSyDeOoPeyuiN8LzRZo2O9d7cZWGtS4suTWg';

  String? _selectedModel;

  Future<void> _selectModel() async {
    if (_selectedModel != null) return;

    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models?key=$_apiKey",
    );

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception("Failed to list models: ${response.body}");
    }

    final data = jsonDecode(response.body);
    final models = data['models'] as List<dynamic>;

    for (var model in models) {
      final methods = model['supportedGenerationMethods'] as List<dynamic>? ?? [];
      if (methods.contains('generateContent') || methods.contains('generateText')) {
        _selectedModel = model['name'] as String;
        print("Selected model: $_selectedModel");
        return;
      }
    }

    throw Exception("No text generation models available for this API key.");
  }

  Future<String> sendMessage(String message) async {
    await _selectModel();
    if (_selectedModel == null) {
      throw Exception("No model selected for text generation.");
    }

    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/$_selectedModel:generateContent?key=$_apiKey",
    );

    final body = {
      "contents": [
        {
          "parts": [
            {"text": message}
          ]
        }
      ]
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      throw Exception("API Error: ${response.body}");
    }
  }
}