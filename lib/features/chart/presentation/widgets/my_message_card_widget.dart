import 'package:flutter/material.dart';
import 'package:spring_finance_practicle/core/utils/helper.dart';

class MyMessageWidget extends StatelessWidget {
  final String message;

  const MyMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: Helper.getScreenWidth(context) / 1.8,
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(5.0),
            child: Text(message),
          ),
          const SizedBox(width: 10),
          const CircleAvatar(radius: 18),
        ],
      ),
    );
  }
}
