import 'package:flutter/material.dart';
import 'package:spring_finance_practicle/features/chart/data/ai_services.dart';
import 'package:spring_finance_practicle/features/chart/data/chart_services.dart';
import 'package:spring_finance_practicle/models/message_model.dart';

class ChatProvider extends ChangeNotifier {
  List<MessageModel> messages = [];
  final scrollController = ScrollController();
  ChatService chatService=ChatService();
  Future<void> getMessages(String email) async {
    messages = chatService.getMessages(email);
    autoScroll();
    notifyListeners();
  }

  Future<void> sendMessage(String msg, String email) async {
    if (msg.isEmpty) return;

    final userMessage = MessageModel(text: msg, isMe: true);
    await chatService.addMessage(email, userMessage);
    messages.add(userMessage);
    notifyListeners();
    autoScroll();

    final aiResponse = await AIService.askQuestion(msg);
    if (aiResponse != null) {
      final aiMessage = MessageModel(text: aiResponse, isMe: false);
      await chatService.addMessage(email, aiMessage);
      messages.add(aiMessage);
      notifyListeners();
      autoScroll();
    }
  }

  void autoScroll() {
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
