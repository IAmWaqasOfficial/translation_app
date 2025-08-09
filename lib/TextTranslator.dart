import 'package:flutter/material.dart';
import 'translation_service.dart';

class TextTranslator extends StatefulWidget {
  const TextTranslator({super.key});

  @override
  State<TextTranslator> createState() => _TextTranslatorState();
}

class _TextTranslatorState extends State<TextTranslator> {

  final TextEditingController _textController = TextEditingController();

  String? _selectedFromLanguage = 'en';
  String? _selectedToLanguage ='es';
  String? _translatedText;


  final Map<String, String> _languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'hi': 'Hindi',
    'ur': 'Urdu',
    'zh': 'Chinese',
    'ar': 'Arabic',
  };

  Future<void> _translateText() async {
    if (_textController.text.isEmpty) return;

    final translated = await TranslationService.translateText(
      text: _textController.text,
      from: _selectedFromLanguage!,
      to: _selectedToLanguage!,
    );

    setState(() {
      _translatedText = translated;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text('Text Translator',style:
          TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),

      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedFromLanguage,
                    items: _languages.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFromLanguage = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'From Language',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedToLanguage,
                    items: _languages.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedToLanguage = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'To Language',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),SizedBox(height: 16),

            TextField(
              controller: _textController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text to translate...',
              ),
            ),


            ElevatedButton(
              onPressed: _translateText,
              child: Text('Translate'),
            ),
            if (_translatedText != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Text(
                    _translatedText!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black),
                  ),
                ),
              ),




          ],
        ),
      ),


    );
  }
}
