import 'package:flutter/material.dart';
import '../controllers/document_translator_controller.dart';

class Documenttranslator extends StatefulWidget {
  const Documenttranslator({super.key});

  @override
  State<Documenttranslator> createState() => _DocumenttranslatorState();
}

class _DocumenttranslatorState extends State<Documenttranslator> {
  final controller = DocumentTranslatorController();

  bool _isLoading = false;

  final Map<String, String> _languages = {
    'auto': 'Auto Detect',
    'en': 'English',
    'es': 'Spanish',
    'hi': 'Hindi',
    'ur': 'Urdu',
    'fr': 'French',
    'de': 'German',
    'ar': 'Arabic',
    'zh': 'Chinese',
    'ru': 'Russian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'pt': 'Portuguese',
  };

  Future<void> _handleUpload() async {
    setState(() {
      _isLoading = true;
    });

    final status = await controller.pickDocument();

    setState(() {
      _isLoading = false;
    });

    if (status == DocumentStatus.noFileSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file selected")),
      );
    } else if (status == DocumentStatus.extractionFailed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to extract text from PDF")),
      );
    } else if (status == DocumentStatus.translationFailed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Translation failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          'Document Translator',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              'Select Document to Translate',
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 20),

            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9Ie3QNexIRJ4bhs5UB2DrfuAGhuHFvH0qcA&s",
              height: 140,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedFromLang,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                    items: _languages.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        controller.selectedFromLang = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedToLang,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                    items: _languages.entries
                        .where((e) => e.key != 'auto')
                        .map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        controller.selectedToLang = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _isLoading ? null : _handleUpload,
              child: const Text("Upload"),
            ),

            const SizedBox(height: 20),

            if (_isLoading) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 10),
                  Text('Processing...', style: TextStyle(fontSize: 14)),
                ],
              ),
            ]

            else if (controller.translatedText != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.translatedText!,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Instructions to Upload Document:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("1. Click the 'Upload' button."),
                  Text("2. Select the PDF document."),
                  Text("3. Choose languages."),
                  Text("4. Translation will appear below."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}