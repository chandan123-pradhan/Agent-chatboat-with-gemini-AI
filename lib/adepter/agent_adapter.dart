
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spring_finance_practicle/models/agent.dart';
class AgentAdapter extends TypeAdapter<Agent> {
  @override
  final int typeId = 0;

  @override
  Agent read(BinaryReader reader) {
    final name = reader.readString();        
    final email = reader.readString();      
    final message = reader.readList().cast<Map<dynamic,dynamic>>();

    return Agent(name: name, email: email, messages: message);
  }

  @override
  void write(BinaryWriter writer, Agent obj) {
    writer.writeString(obj.name);             
    writer.writeString(obj.email);           
    writer.writeList(obj.messages);
  }
}
