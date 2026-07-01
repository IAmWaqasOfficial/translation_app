import 'package:flutter/foundation.dart';
import 'package:translation_app/services/ai_translator_chat_service.dart';
import 'package:translation_app/models/chat_message.dart';

class DeepSeekChatController {
  final GeminiService _chatService = GeminiService();

  final List<ChatMessage> messages = [];
  bool isLoading = false;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    messages.add(ChatMessage(text: text, isUser: true));
    isLoading = true;

    try {
      debugPrint("📤 Sending message to AI: $text");

      final reply = await _chatService.sendMessage(text);

      debugPrint("🤖 Received AI reply: $reply");

      messages.add(ChatMessage(text: reply, isUser: false));
    } catch (e, stackTrace) {
      debugPrint("❌ Error while sending message: $e");
      debugPrint("📌 StackTrace: $stackTrace");

      messages.add(
        ChatMessage(
          text: "Oops! Something went wrong. Please try again.",
          isUser: false,
        ),
      );
    } finally {
      isLoading = false;
      debugPrint("✅ sendMessage finished");
    }
  }
}
