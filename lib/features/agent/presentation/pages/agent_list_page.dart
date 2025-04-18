import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring_finance_practicle/core/constants/app_string.dart';
import 'package:spring_finance_practicle/core/utils/color_utils.dart';
import 'package:spring_finance_practicle/features/agent/presentation/pages/add_agent_page.dart';
import 'package:spring_finance_practicle/features/agent/presentation/provider/agent_provider.dart';
import 'package:spring_finance_practicle/routes/app_routes.dart';

class AgentListPage extends StatefulWidget {
  const AgentListPage({super.key});

  @override
  State<AgentListPage> createState() => _AgentListPageState();
}

class _AgentListPageState extends State<AgentListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AgentProvider>().getAgents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.mainColor,
        title: const Text(
          AppString.chat,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Consumer<AgentProvider>(
        builder: (_, agentProvider, __) {
          final agents = agentProvider.agentsList;

          if (agents.isEmpty) {
            return const Center(child: Text(AppString.noAggentCreated));
          }

          return ListView.builder(
            itemCount: agents.length,
            itemBuilder: (_, index) {
              final agent = agents[index];

              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.chat,
                    arguments: {
                      'email': agent.email,
                      'name': agent.name,
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black12, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Center(
                          child: Icon(Icons.person, size: 18, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              agent.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              agent.email,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_horiz_outlined, size: 18, color: Colors.black26),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.mainColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAgentPage()),
          );
        },
        child: const Icon(Icons.add, size: 25, color: Colors.white),
      ),
    );
  }
}
