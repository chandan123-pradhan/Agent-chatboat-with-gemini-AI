import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring_finance_practicle/core/constants/app_string.dart';
import 'package:spring_finance_practicle/core/utils/color_utils.dart';
import 'package:spring_finance_practicle/features/chart/presentation/provider/chart_provider.dart';
import 'package:spring_finance_practicle/features/chart/presentation/widgets/ai_message_card_widget.dart';
import 'package:spring_finance_practicle/features/chart/presentation/widgets/my_message_card_widget.dart';

class ChatPage extends StatefulWidget {
  final String email;
  final String name;

  const ChatPage({
    required this.email,
    required this.name,
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().getMessages(widget.email);
    });
  }

  void _sendMessage(ChatProvider provider) {
    final text = _chatController.text.trim();
    if (text.isNotEmpty) {
      provider.sendMessage(text, widget.email);
      _chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: ColorUtils.mainColor,
        title: Text(
          widget.name,
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (_, chatProvider, __) {
                final messages = chatProvider.messages;

                if (messages.isEmpty) {
                  return const Center(child: Text(AppString.noChatsAvailable));
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 12),
                  controller: chatProvider.scrollController,
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    final msg = messages[index];
                    return msg.isMe
                        ? MyMessageWidget(message: msg.text)
                        : AiMessageWidget(message: msg.text);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Consumer<ChatProvider>(
              builder: (_, chatProvider, __) {
                return _buildChatInput(chatProvider);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput(ChatProvider chatProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: _chatController,
        textInputAction: TextInputAction.send,
        onFieldSubmitted: (_) => _sendMessage(chatProvider),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.send, color: ColorUtils.mainColor),
            onPressed: () => _sendMessage(chatProvider),
          ),
          hintText: AppString.typeHere,
          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
