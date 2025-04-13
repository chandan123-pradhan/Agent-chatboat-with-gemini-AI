import 'package:hive_flutter/hive_flutter.dart';
import 'package:spring_finance_practicle/models/agent.dart';

class AgentService {
  final Box<Agent> _agentBox=Hive.box<Agent>('agents');

  Future<void>addAgent(String name,String email)async{
    final agent=Agent(name: name, email: email, message: []);
    int result=await _agentBox.add(agent);
    print(result);
  }


  List<Agent>getAllAgents(){
    List agentsList= _agentBox.values.toList();
    List<Agent> result=[];
    for(Agent agent in agentsList){
      result.add(Agent(name: agent.email, email: agent.name, message: agent.message));
    }
    return result;
  }
}