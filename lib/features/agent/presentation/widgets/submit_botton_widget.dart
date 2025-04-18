import 'package:flutter/material.dart';
import 'package:spring_finance_practicle/core/constants/app_string.dart';
import 'package:spring_finance_practicle/core/utils/color_utils.dart';

class SubmitBottonWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  const SubmitBottonWidget(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtils.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          onTap();
        },
        child:  Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
