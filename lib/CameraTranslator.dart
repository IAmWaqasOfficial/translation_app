import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'translation_service.dart'; // Import your service file

class CameraTranslator extends StatefulWidget {
  const CameraTranslator({Key? key}) : super(key: key);

  @override
  State<CameraTranslator> createState() => _CameraTranslatorState();
}

class _CameraTranslatorState extends State<CameraTranslator> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String _extractedText = '';
  String _translatedText = '';
  String? _selectedFromLang = 'auto';
  String? _selectedToLang = 'en';

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

  Future<void> _pickImage() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (photo != null) {
        setState(() {
          _imageFile = File(photo.path);
          _extractedText = '';
          _translatedText = '';
        });
        await _extractTextFromImage(File(photo.path));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _extractTextFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);

    await textRecognizer.close();

    setState(() {
      _extractedText = recognizedText.text;
    });

    if (_extractedText.isNotEmpty && _selectedToLang != null) {
      await _translateText();
    }
  }

  Future<void> _translateText() async {
    try {
      final translated = await TranslationService.translateText(
        text: _extractedText,
        from: _selectedFromLang == 'auto' ? null : _selectedFromLang,
        to: _selectedToLang!,
      );

      setState(() {
        _translatedText = translated;
      });
    } catch (e) {
      debugPrint('Translation error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          title: const Text('Camera Translator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedFromLang,
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
                      onChanged: (value) =>
                          setState(() => _selectedFromLang = value),
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedToLang,
                      decoration: const InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                      ),
                      items: _languages.entries
                          .where((entry) => entry.key != 'auto')
                          .map((entry) {
                        return DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => _selectedToLang = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (_imageFile != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _imageFile!,
                      height: 200,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              const SizedBox(height: 10,),

              // Extracted Text Section
              if (_extractedText.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    "📄 Extracted Text",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _extractedText,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),

// Translated Text Section
              if (_translatedText.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    "🌐 Translated Text",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade900, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      height: 300,
                      child: Text(
                        _translatedText,
                        maxLines: null,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),


            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
