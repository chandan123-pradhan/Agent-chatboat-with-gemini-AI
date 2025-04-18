import 'package:flutter/material.dart';
import 'package:spring_finance_practicle/core/utils/helper.dart';

class AiMessageWidget extends StatelessWidget {
  final String message;

  const AiMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 18),
          const SizedBox(width: 10),
          Container(
            width: Helper.getScreenWidth(context) / 1.8,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(5.0),
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
