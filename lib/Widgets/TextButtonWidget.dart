import 'package:flutter/material.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';

class TextButtonWidget extends StatelessWidget {
  String text;
  Function onPressedFunction;
  double width;
  double height;
  TextButtonWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.onPressedFunction,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.yellowColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
