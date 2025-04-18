import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring_finance_practicle/core/constants/app_string.dart';
import 'package:spring_finance_practicle/core/utils/color_utils.dart';
import 'package:spring_finance_practicle/features/agent/presentation/provider/agent_provider.dart';
import 'package:spring_finance_practicle/features/agent/presentation/widgets/input_field_widget.dart';
import 'package:spring_finance_practicle/features/agent/presentation/widgets/submit_botton_widget.dart';

class AddAgentPage extends StatefulWidget {
  const AddAgentPage({super.key});

  @override
  State<AddAgentPage> createState() => _AddAgentPageState();
}

class _AddAgentPageState extends State<AddAgentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.mainColor,
        leading: IconButton(
          icon:
              const Icon(Icons.navigate_before, size: 30, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppString.addAgent,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Consumer<AgentProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: provider.formKey,
              child: Column(
                children: [
                  InputFieldWidget(
                    controller: provider.emailController,
                    hintText: "Email-ID",
                    validator: (value) => value == null || value.isEmpty
                        ? "Please enter agent email"
                        : null,
                  ),
                  const SizedBox(height: 15),
                  InputFieldWidget(
                    controller: provider.nameController,
                    hintText: "Agent-Name",
                    validator: (value) => value == null || value.isEmpty
                        ? "Please enter agent name"
                        : null,
                  ),
                  const SizedBox(height: 25),
                  SubmitBottonWidget(
                    title: AppString.submit,
                    onTap: () {
                      provider.addAgent(context);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
