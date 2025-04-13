import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spring_finance_practicle/models/agent.dart';
import 'package:spring_finance_practicle/models/agent_model.dart';
import 'package:spring_finance_practicle/models/message_model.dart';
import 'package:spring_finance_practicle/services/agent_service.dart';

class ChartListProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  List<Agent> agentsList = [];
  final agentService = AgentService();
  List<MessageModel> agetMessage = [];

  final ScrollController scrollController = ScrollController();

  void addAgents(context) async {
    // if (formKey.currentState!.validate()==true) {
  
    await agentService.addAgent(nameController.text, emailController.text);
 
 

    getAgents();
    Navigator.pop(context);
  }

  getAgents() async {
    agentsList = agentService.getAllAgents();
    notifyListeners();
  }

  Future<void> addAgentMessage(String msg, bool isMe, String email) async {
    if (msg.isNotEmpty) {
      final box = Hive.box<Agent>('agents');
      int? key = getAgentKey(email);

      if (key != null) {
        final agent = box.get(key);
        if (agent != null) {
          if (isMe) {
            agent.message.add("User: $msg");
          } else {
            agent.message.add("AI: $msg");
          }

          await agent.save();
          agetMessage.add(MessageModel(isME: isMe, Message: msg));
          autoScroll();
          notifyListeners();
          if (isMe == true) {
            askQuestion(msg, email);
          }
        }
      }
    } else {
      print("message not avaiable");
    }
  }

  Future<void> getAgentsMessage(email) async {
    int? key = getAgentKey(email);
    agetMessage.clear();
    if (key != null) {
      final box = Hive.box<Agent>('agents');
      final agent = box.get(key);

      for (var msg in agent!.message) {
        if (msg.startsWith("User:")) {
          MessageModel messageModel =
              MessageModel(isME: true, Message: msg.substring(6));
          agetMessage.add(messageModel);
        } else {
          MessageModel messageModel =
              MessageModel(isME: false, Message: msg.substring(4));
          agetMessage.add(messageModel);
        }
      }
    }
    autoScroll();
    notifyListeners();
  }

  int? getAgentKey(String email) {
    final box = Hive.box<Agent>('agents');
    for (var key in box.keys) {
      final agent = box.get(key);
      if (agent!.name == email) {
        return key;
      }
    }
  }

  askQuestion(
    String qn,
    String email,
  ) async {
    try {
      final model = GenerativeModel(
          model: 'models/gemini-1.5-flash',
          apiKey: 'AIzaSyC5XI-g0fbPh_JLJIFVxAp_PfJYDilXR3M');
      final content = [Content.text(qn)];
      final response = await model.generateContent(content);
      addAgentMessage(response.text!, false, email);
    } catch (e) {
      print(e);
    }
  }

  autoScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        notifyListeners();
      }
    });
  }
}
