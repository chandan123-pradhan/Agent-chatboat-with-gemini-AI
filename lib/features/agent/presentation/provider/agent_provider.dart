import 'package:flutter/material.dart';
import 'package:spring_finance_practicle/features/agent/data/agent_services.dart';
import 'package:spring_finance_practicle/models/agent.dart';

class AgentProvider extends ChangeNotifier {
  final AgentService _agentService = AgentService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Agent> agentsList = [];

  Future<void> addAgent(BuildContext context) async {
    await _agentService.addAgent(nameController.text, emailController.text);
    getAgents();
    Navigator.pop(context);
  }

  void getAgents() {
    agentsList = _agentService.getAllAgents();
    notifyListeners();
  }
}
