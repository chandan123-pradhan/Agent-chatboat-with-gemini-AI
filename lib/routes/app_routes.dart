import 'package:flutter/material.dart';
import 'package:spring_finance_practicle/features/agent/presentation/pages/agent_list_page.dart';
import 'package:spring_finance_practicle/features/chart/presentation/pages/chart_page.dart';

class AppRoutes {
  static const String agentList = '/';
  static const String chat = '/chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case agentList:
        return MaterialPageRoute(builder: (_) => const AgentListPage());

      case chat:
        final args = settings.arguments as Map<String, dynamic>;
        final agentEmail = args['email'] as String;
        final agentName = args['name'] as String;

        return MaterialPageRoute(
          builder: (_) => ChatPage(email: agentEmail, name: agentName),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
