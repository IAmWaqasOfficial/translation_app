import 'package:flutter/material.dart';
import 'package:translation_app/controllers/text_translation_controller.dart';

class TextTranslator extends StatefulWidget {
  const TextTranslator({super.key});

  @override
  State<TextTranslator> createState() => _TextTranslatorState();
}

class _TextTranslatorState extends State<TextTranslator> {
  final TextEditingController textController = TextEditingController();
  final controller = TextTranslationController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          'Text Translator',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedFromLanguage,
                      items: _languages.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          controller.selectedFromLanguage = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'From Language',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedToLanguage,
                      items: _languages.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          controller.selectedToLanguage = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'To Language',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              TextField(
                controller: textController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text to translate...',
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async {
                  await controller.translateText(textController.text);
                  setState(() {});
                },
                child: const Text('Translate'),
              ),

              const SizedBox(height: 20),

              if (controller.translatedText != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Text(
                    controller.translatedText!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}