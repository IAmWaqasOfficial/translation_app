import 'package:flutter/material.dart';
import 'package:translation_app/controllers/ai_translation_controller.dart';
import 'package:translation_app/models/chat_message.dart';

class DeepSeekChatView extends StatefulWidget {
  const DeepSeekChatView({Key? key}) : super(key: key);

  @override
  State<DeepSeekChatView> createState() => _DeepSeekChatViewState();
}

class _DeepSeekChatViewState extends State<DeepSeekChatView> {
  final TextEditingController _textController = TextEditingController();
  final DeepSeekChatController controller = DeepSeekChatController();

  void _handleSend() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {});
    _textController.clear();

    await controller.sendMessage(text);
    setState(() {});
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        backgroundColor: Colors.grey.shade200,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) =>
                  _buildMessage(controller.messages[index]),
            ),
          ),
          if (controller.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _handleSend(),
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: controller.isLoading ? null : _handleSend,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

