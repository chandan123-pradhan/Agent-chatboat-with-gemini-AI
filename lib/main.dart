import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spring_finance_practicle/adepter/agent_adapter.dart';
import 'package:spring_finance_practicle/features/agent/presentation/provider/agent_provider.dart';
import 'package:spring_finance_practicle/features/chart/presentation/provider/chart_provider.dart';
import 'package:spring_finance_practicle/models/agent.dart';
import 'package:spring_finance_practicle/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AgentAdapter());
  await Hive.openBox<Agent>('agents');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AgentProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.agentList,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
