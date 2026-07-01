
import 'package:flutter/material.dart';
import 'package:translation_app/controllers/camera_translator_controller.dart';

class CameraTranslator extends StatefulWidget {
  const CameraTranslator({Key? key}) : super(key: key);

  @override
  State<CameraTranslator> createState() => _CameraTranslatorState();
}

class _CameraTranslatorState extends State<CameraTranslator> {
  final controller = CameraTranslationController();


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
                      onChanged: (value) =>
                          setState(() => controller.selectedFromLang = value),
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedToLang,
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
                          setState(() => controller.selectedToLang = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (controller.imageFile != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      controller.imageFile!,
                      height: 200,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              const SizedBox(height: 10,),

              if (controller.extractedText.isNotEmpty) ...[
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
                 controller.extractedText,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),

              if (controller.translatedText.isNotEmpty) ...[
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
                        controller.translatedText,
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
        onPressed: ()async {
          await controller.pickImage();

        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
