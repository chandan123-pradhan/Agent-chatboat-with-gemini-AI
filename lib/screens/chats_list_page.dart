import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring_finance_practicle/provider/chart_list_provider.dart';
import 'package:spring_finance_practicle/screens/add_agent_page.dart';
import 'package:spring_finance_practicle/screens/chat_page.dart';
import 'package:spring_finance_practicle/utils/color_utils.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChartListProvider>(context, listen: false).getAgents();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.mainColor,
        title: Text(
          "Chats",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Consumer<ChartListProvider>(
          builder: (context, chatListProvider, child) {
        return 
        chatListProvider.agentsList.isEmpty?Center(
          child: Text("No agent created"),
        ):

        
        ListView.builder(
            itemCount: chatListProvider.agentsList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChartPage(
                      agent: chatListProvider.agentsList[index],
                    );
                  }));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  // height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black12))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1, color: Colors.grey)),
                                      child: Center(child: Icon(Icons.person,size: 18,color: Colors.grey,),),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chatListProvider.agentsList[index].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  chatListProvider.agentsList[index].email,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Icons.more_horiz_outlined,
                          size: 18,
                          color: Colors.black26,
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.mainColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddAgentPage();
          }));
        },
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
