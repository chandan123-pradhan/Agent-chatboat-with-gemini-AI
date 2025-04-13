import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring_finance_practicle/provider/chart_list_provider.dart';
import 'package:spring_finance_practicle/utils/color_utils.dart';

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
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.navigate_before,
              size: 30,
              color: Colors.white,
            )),
        backgroundColor: ColorUtils.mainColor,
        title: Text(
          "Add Agent",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),
        ),
      ),
      body: Consumer<ChartListProvider>(

        builder: (context,chatListProvider,child) {
          return SingleChildScrollView(
            child: Form(
              key: chatListProvider.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: chatListProvider.emailController,
                        decoration: InputDecoration(
                          hintText: "Email-ID",
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter agent email";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: chatListProvider.nameController,
                        decoration: InputDecoration(
                          hintText: "Agent-Name",
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter agent email";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (){
                        chatListProvider.addAgents(context);
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorUtils.mainColor),
                        alignment: Alignment.center,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
