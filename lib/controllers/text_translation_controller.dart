import 'package:translation_app/services/translation_service.dart';


class TextTranslationController {

  String? selectedFromLanguage = 'en';
  String? selectedToLanguage ='es';
  String? translatedText;

  Future<void> translateText(String word ) async {
    if (word.isEmpty) return;

    final translated = await TranslationService.translateText(
      text:word,
      from: selectedFromLanguage!,
      to: selectedToLanguage!,
    );

      translatedText = translated;

  }


}



















