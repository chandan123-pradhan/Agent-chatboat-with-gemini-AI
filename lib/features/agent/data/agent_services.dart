import 'package:spring_finance_practicle/core/services/hive_services.dart';
import 'package:spring_finance_practicle/models/agent.dart';

class AgentService {
  final HiveServices _hive = HiveServices();

  Future<void> addAgent(String name, String email) async {
    final agent = Agent(name: name, email: email, messages: []);
    await _hive.addAgent(agent);
  }

  List<Agent> getAllAgents() {
    return _hive.getAllAgents();
  }
}
