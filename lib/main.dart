import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spring_finance_practicle/adepter/agent_adapter.dart';
import 'package:spring_finance_practicle/models/agent.dart';
import 'package:spring_finance_practicle/provider/chart_list_provider.dart';
import 'package:spring_finance_practicle/screens/chats_list_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AgentAdapter());
  await Hive.openBox<Agent>('agents');
  runApp(
    MultiProvider(providers: 
    [
      ChangeNotifierProvider(create: (_)=>ChartListProvider())
    ],
    child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chart App',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChatsListPage()
    );
  }
}
