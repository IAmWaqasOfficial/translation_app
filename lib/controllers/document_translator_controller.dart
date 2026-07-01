import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:translation_app/services/translation_service.dart';

enum DocumentStatus {
  success,
  noFileSelected,
  extractionFailed,
  translationFailed,
}

class DocumentTranslatorController {
  String? extractedText;
  String? pickedFileName;
  String? translatedText;
  String? selectedFromLang = 'auto';
  String? selectedToLang = 'en';

  Future<DocumentStatus> pickDocument() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null || result.files.isEmpty) {
        return DocumentStatus.noFileSelected;
      }

      final file = File(result.files.single.path!);

      pickedFileName = result.files.single.name;
      extractedText = null;
      translatedText = null;

      String text = await _extractTextFromFile(file);

      if (text.isEmpty) {
        debugPrint("⚠️ PDF text empty → using OCR fallback");
        text = await _extractTextWithOCR(file);
      }

      if (text.isEmpty) {
        return DocumentStatus.extractionFailed;
      }

      extractedText = text;

      final safeText = text.length > 4000 ? text.substring(0, 4000) : text;

      translatedText = await TranslationService.translateText(
        text: safeText,
        from: selectedFromLang == 'auto' ? null : selectedFromLang,
        to: selectedToLang!,
      );

      return DocumentStatus.success;

    } catch (e) {
      debugPrint("❌ Error: $e");
      return DocumentStatus.translationFailed;
    }
  }

  Future<String> _extractTextFromFile(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);

      final text = PdfTextExtractor(document).extractText();

      document.dispose();

      return text;
    } catch (e) {
      debugPrint("❌ PDF extraction failed: $e");
      return "";
    }
  }

  Future<String> _extractTextWithOCR(File file) async {
    try {
      final textRecognizer = TextRecognizer();

      final inputImage = InputImage.fromFile(file);
      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

      await textRecognizer.close();

      return recognizedText.text;
    } catch (e) {
      debugPrint("❌ OCR failed: $e");
      return "";
    }
  }
}