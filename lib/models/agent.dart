import 'package:hive_flutter/hive_flutter.dart';

class Agent extends HiveObject {
  final String name;
  final String email;
  final List<String> message;
  Agent({required this.name, required this.email, required this.message});
}
