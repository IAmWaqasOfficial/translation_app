

import 'package:flutter/material.dart';
import 'package:translation_app/services/ai_translator_chat_service.dart';
import 'package:translation_app/services/ai_dictionary_service.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  String definition = '';
  List<dynamic> synonyms = [];
  String example = '';

  Future<void> _searchWord() async {
    final word = _controller.text.trim();
    if (word.isEmpty) return;

    setState(() {
      isLoading = true;
      definition = '';
      synonyms = [];
      example = '';
    });

    try {
      final data = await AiDictionaryService.getWordData(word);

      setState(() {
        definition = data['definition'] ?? '';
        synonyms = data['synonyms'] ?? [];
        example = data['example'] ?? '';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        definition = 'Error: $e';
        isLoading = false;
      });
    }
  }

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
            // Input field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter a word',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _searchWord(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: isLoading ? null : _searchWord,
                  child: const Text('Search'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Loading
            if (isLoading) const CircularProgressIndicator(),

            // Definition
            if (!isLoading && definition.isNotEmpty) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Definition
                      Row(
                        children: [
                          const Icon(Icons.menu_book, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Definition',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        definition,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),

                      const SizedBox(height: 16),

                      // Synonyms
                      Row(
                        children: [
                          const Icon(Icons.sync_alt, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            'Synonyms',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      synonyms.isNotEmpty
                          ? Wrap(
                        spacing: 8,
                        children: synonyms
                            .map((syn) => Chip(
                          label: Text(
                            syn,
                            style: const TextStyle(fontSize: 14),
                          ),
                          backgroundColor: Colors.green.shade50,
                        ))
                            .toList(),
                      )
                          : const Text('No synonyms found.'),

                      const SizedBox(height: 16),

                      // Example
                      Row(
                        children: [
                          const Icon(Icons.lightbulb, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'Example',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        example,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]

          ],
        ),
      ),
    );
  }
}
