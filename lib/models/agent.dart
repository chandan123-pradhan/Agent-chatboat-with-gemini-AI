class Agent {
  final String name;
  final String email;
  final List<Map<dynamic, dynamic>> messages;

  Agent({
    required this.name,
    required this.email,
    required this.messages,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      name: json['name'],
      email: json['email'],
      messages: List<Map<String, dynamic>>.from(
        (json['messages'] ?? []).map((e) => Map<dynamic, dynamic>.from(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'messages': messages,
    };
  }
}
