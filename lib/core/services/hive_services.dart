import 'package:hive_flutter/hive_flutter.dart';
import 'package:spring_finance_practicle/models/agent.dart';

class HiveServices {
  final Box<Agent> _agentBox = Hive.box<Agent>('agents');

  Future<void> addAgent(Agent agent) async {
    await _agentBox.add(agent);
  }

  List<Agent> getAllAgents() {
    return _agentBox.values.toList();
  }

  Agent? getAgentByEmail(String email) {
    try {
      return _agentBox.values.firstWhere((agent) => agent.email == email);
    } catch (e) {
      return null;
    }
  }

  int? getAgentKeyByEmail(String email) {
    for (var key in _agentBox.keys) {
      final agent = _agentBox.get(key);
      if (agent?.email == email) return key;
    }
    return null;
  }

  Future<void> updateAgent(int key, Agent updatedAgent) async {
    await _agentBox.put(key, updatedAgent);
  }
}
