import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotController extends GetxController {
  final messages = <ChatMessage>[].obs;
  final isLoading = false.obs;
  final textController = ''.obs;
  final ScrollController scrollController = ScrollController();

  late final GenerativeModel _model;

  @override
  void onInit() {
    super.onInit();
    // Initialize the model using FirebaseAI.googleAI()
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash-lite',
    );
    // Add initial welcome message
    messages.add(
      ChatMessage(text: 'Hello! How can I help you today?', isUser: false),
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    isLoading.value = true;
    messages.add(ChatMessage(text: text, isUser: true));
    scrollToBottom();

    try {
      final content = [Content.text(text)];
      final response = await _model.generateContent(content);

      if (response.text != null) {
        messages.add(ChatMessage(text: response.text!, isUser: false));
      } else {
        messages.add(
          ChatMessage(
            text: 'Sorry, I could not generate a response.',
            isUser: false,
            isError: true,
          ),
        );
      }
    } catch (e) {
      messages.add(
        ChatMessage(text: 'Error: $e', isUser: false, isError: true),
      );
    } finally {
      isLoading.value = false;
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final bool isError;

  ChatMessage({required this.text, required this.isUser, this.isError = false});
}
