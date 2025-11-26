import 'package:airnav_helpdesk/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'chatbot_controller.dart';

class ChatbotPage extends GetView<ChatbotController> {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _inputController = TextEditingController();

    return Scaffold(
      appBar: AppBarWidget(
        titleText: 'Chatbot',
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return _buildMessageBubble(context, message);
                },
              ),
            ),
          ),
          if (controller.isLoading.value)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          _buildInputArea(_inputController),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUser
              ? Get.theme.colorScheme.primary
              : (Get.isDarkMode ? Colors.grey[800] : Colors.grey[200]),
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: MarkdownBody(
          data: message.text,
          styleSheet: MarkdownStyleSheet(
            p: TextStyle(
              color: message.isUser
                  ? Colors.white
                  : Get.theme.textTheme.bodyLarge?.color,
            ),
            code: TextStyle(
              backgroundColor: message.isUser
                  ? Colors.white.withOpacity(0.1)
                  : (Get.isDarkMode ? Colors.grey[700] : Colors.grey[300]),
              color: message.isUser
                  ? Colors.white
                  : Get.theme.textTheme.bodyLarge?.color,
            ),
            codeblockDecoration: BoxDecoration(
              color: message.isUser
                  ? Colors.white.withOpacity(0.1)
                  : (Get.isDarkMode ? Colors.grey[700] : Colors.grey[300]),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Ketik pesan...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              onSubmitted: (value) {
                this.controller.sendMessage(value);
                controller.clear();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Get.theme.colorScheme.primary,
            onPressed: () {
              this.controller.sendMessage(controller.text);
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
