import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring_finance_practicle/models/agent.dart';
import 'package:spring_finance_practicle/provider/chart_list_provider.dart';
import 'package:spring_finance_practicle/utils/color_utils.dart';
import 'package:spring_finance_practicle/utils/helper_utils.dart';

class ChartPage extends StatefulWidget {
  Agent agent;
  ChartPage({required this.agent});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChartListProvider>(context, listen: false)
          .getAgentsMessage(widget.agent.email);
    });

    // TODO: implement initState
    super.initState();
  }

  final _chatField = new TextEditingController();
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
          widget.agent.name,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height/1,
              child: Consumer<ChartListProvider>(
                  builder: (context, chatListProvider, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    controller: chatListProvider.scrollController,
                    itemCount: chatListProvider.agetMessage.length,
                    itemBuilder: (context, index) {
                      return chatListProvider.agetMessage[index].isME
                          ? myMessage(
                              chatListProvider.agetMessage[index].Message)
                          : aiMessage(
                              chatListProvider.agetMessage[index].Message);
                    });
              }),
            ),
          ),
          Positioned(
            bottom: 35.0,
            left: 16.0,
            right: 16.0,
            child: Consumer<ChartListProvider>(
                builder: (context, chatListProvider, child) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _chatField,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          chatListProvider.addAgentMessage(
                              _chatField.text, true, widget.agent.email);
                          _chatField.clear();
                        },
                        child: Icon(
                          Icons.send,
                          size: 25,
                          color: ColorUtils.mainColor,
                        )),
                    hintText: "Type here...",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget myMessage(String message) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // height: 70,
            width: HelperUtils.getScreenWidth(context) / 1.8,
            decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(message),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 18,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget aiMessage(String message) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              // height: 70,
              width: HelperUtils.getScreenWidth(context) / 1.8,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
