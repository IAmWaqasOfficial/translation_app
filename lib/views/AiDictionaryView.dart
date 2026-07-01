import 'package:flutter/material.dart';
import 'package:translation_app/controllers/ai_dic_controller.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _Tcontroller = TextEditingController();
  final AiDictionaryController controller = AiDictionaryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Dictionary'),
        backgroundColor: Colors.grey.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _Tcontroller,
                    decoration: const InputDecoration(
                      labelText: 'Enter a word',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _searchWord(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchWord,
                  child: const Text('Search'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (controller.isLoading) const CircularProgressIndicator(),

            const SizedBox(height: 20),

            if (controller.definition.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionHeader(
                              icon: Icons.menu_book,
                              color: Colors.blue,
                              title: 'Definition'),
                          const SizedBox(height: 6),
                          Text(
                            controller.definition,
                            style: const TextStyle(
                                fontSize: 16, height: 1.4),
                          ),
                          const SizedBox(height: 16),

                          _sectionHeader(
                              icon: Icons.sync_alt,
                              color: Colors.green,
                              title: 'Synonyms'),
                          const SizedBox(height: 6),
                          controller.synonyms.isNotEmpty
                              ? Wrap(
                            spacing: 8,
                            children: controller.synonyms
                                .map((syn) => Chip(
                              label: Text(
                                syn,
                                style:
                                const TextStyle(fontSize: 14),
                              ),
                              backgroundColor:
                              Colors.green.shade50,
                            ))
                                .toList(),
                          )
                              : const Text('No synonyms found.'),
                          const SizedBox(height: 16),

                          _sectionHeader(
                              icon: Icons.lightbulb,
                              color: Colors.orange,
                              title: 'Example'),
                          const SizedBox(height: 6),
                          Text(
                            controller.example,
                            style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(
      {required IconData icon, required Color color, required String title}) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, ),
        ),
      ],
    );
  }

  Future<void> _searchWord() async {
    final word = _Tcontroller.text.trim();
    if (word.isEmpty) return;

    setState(() {
      controller.isLoading = true;
    });

    try {
      await controller.searchWord(word);
    } catch (e) {
      controller.definition = 'Error: $e';
      controller.synonyms = [];
      controller.example = '';
    } finally {
      setState(() {
        controller.isLoading = false;
      });
    }
  }
}