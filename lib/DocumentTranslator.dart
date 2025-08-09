import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'translation_service.dart'; // your API wrapper

class Documenttranslator extends StatefulWidget {
  const Documenttranslator({super.key});

  @override
  State<Documenttranslator> createState() => _DocumenttranslatorState();
}

class _DocumenttranslatorState extends State<Documenttranslator> {
  String? _pickedFileName;
  String? _extractedText;
  String? _translatedText;
  bool _isLoading = false;

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

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {

      var storageStatus = await Permission.storage.status;

      if (storageStatus.isGranted) return true;

      // Try requesting storage permission
      storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) return true;

      // On Android 11+ (API 30+), also try manage external storage
      var manageStorageStatus = await Permission.manageExternalStorage.status;
      if (manageStorageStatus.isGranted) return true;

      manageStorageStatus = await Permission.manageExternalStorage.request();
      return manageStorageStatus.isGranted;
    } else if (Platform.isIOS) {
      // iOS: no extra permission required for file_picker
      return true;
    }

    return false;
  }


  Future<String> _extractTextFromFile(File file) async {
    final bytes = await file.readAsBytes();
    final PdfDocument document = PdfDocument(inputBytes: bytes);
    final String text = PdfTextExtractor(document).extractText();
    document.dispose();
    return text;
  }

  Future<void> _pickDocument() async {
    bool permissionGranted = await _requestPermission();
    if (!permissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission is required to pick files.')),
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);

      setState(() {
        _pickedFileName = result.files.single.name;
        _isLoading = true;
        _translatedText = null;
        _extractedText = null;
      });

      try {
        final extracted = await _extractTextFromFile(file);

        setState(() {
          _extractedText = extracted; // ✅ store extracted text
        });

        final translated = await TranslationService.translateText(
          text: extracted,
          from: _selectedFromLang == 'auto' ? null : _selectedFromLang,
          to: _selectedToLang!,
        );

        setState(() {
          _translatedText = translated;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text('Document Translator',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Select Document to Translate',
                style: TextStyle(fontSize: 14)),
            const SizedBox(height: 20),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9Ie3QNexIRJ4bhs5UB2DrfuAGhuHFvH0qcA&s",
              height: 140,
            ),
            const SizedBox(height: 20),

            /// Language dropdowns
            Row(
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
                const SizedBox(width: 10),
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

            ElevatedButton(
              onPressed: _pickDocument,
              child: const Text("Upload"),
            ),




            const SizedBox(height: 20),

            if (_isLoading && _extractedText != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 10),
                  Text('Translating...', style: TextStyle(fontSize: 14)),
                ],
              ),
            ] else if (_translatedText != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _translatedText!,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],

            const SizedBox(height: 30),

            /// Instruction box
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
                  Text("Instructions to Upload Document:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue)),
                  SizedBox(height: 8),
                  Text("1. Click the 'Upload' button."),
                  Text("2. Select the PDF document you want to translate."),
                  Text("3. Choose source and destination languages."),
                  Text("4. The original and translated text will be shown."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
