import 'package:spring_finance_practicle/core/services/hive_services.dart';
import 'package:spring_finance_practicle/models/message_model.dart';

class ChatService {
  final HiveServices _hive = HiveServices();

  List<MessageModel> getMessages(String email) {
    final agent = _hive.getAgentByEmail(email);
    if (agent == null) return [];

    return agent.messages
        .map((msg) => MessageModel.fromJson(Map<String, dynamic>.from(msg)))
        .toList();
  }

  Future<void> addMessage(String email, MessageModel msg) async {
    final key = _hive.getAgentKeyByEmail(email);
    final agent = _hive.getAgentByEmail(email);
    if (agent != null && key != null) {
      agent.messages.add(msg.toJson());
      await _hive.updateAgent(key, agent);
    }
  }
}
