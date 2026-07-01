import 'package:translation_app/services/translation_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


class CameraTranslationController {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String extractedText = '';
  String translatedText = '';
  String? selectedFromLang = 'auto';
  String? selectedToLang = 'en';


  Future<void> pickImage() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (photo != null) {

          imageFile = File(photo.path);
          extractedText = '';
          translatedText = '';

        await _extractTextFromImage(File(photo.path));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  Future<void> _extractTextFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);

    await textRecognizer.close();


      extractedText = recognizedText.text;


    if (extractedText.isNotEmpty && selectedToLang != null) {
      await translateText();
    }
  }

  Future<void> translateText() async {
    try {
      final translated = await TranslationService.translateText(
        text: extractedText,
        from: selectedFromLang == 'auto' ? null : selectedFromLang,
        to: selectedToLang!,
      );


        translatedText = translated;

    } catch (e) {
      print('Translation error: $e');
    }
  }




}