import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static Future<String> translateText({
    required String text,
    String? from, // Optional: leave null to auto-detect
    required String to,
  }) async {
    try {
      final uri = Uri.https(
        'ftapi.pythonanywhere.com',
        '/translate',
        {
          if (from != null) 'sl': from,
          'dl': to,
          'text': text,
        },
      );

      final response = await http.get(uri);

      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['destination-text'] ?? 'No translation found.';
      } else {
        throw Exception('Translation failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Something went wrong');
    }
  }
}
