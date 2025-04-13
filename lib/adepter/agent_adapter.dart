
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spring_finance_practicle/models/agent.dart';

class AgentAdapter  extends TypeAdapter<Agent> {
  @override
  final int typeId=0;

  @override 
  Agent read(BinaryReader reader){
    final email=reader.readString();
    final name=reader.readString();
    final message=reader.readList().cast<String>();
    
    return Agent(name: name, email: email, message: message);
  }

@override
void write(BinaryWriter writer,Agent obj){
  writer.writeString(obj.name);
  writer.writeString(obj.email);
  writer.writeList(obj.message);
}
 


}