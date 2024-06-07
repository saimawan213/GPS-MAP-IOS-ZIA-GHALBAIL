import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Ads/Colors.dart';

class SubscriptionWidget extends StatefulWidget {
  SubscriptionWidget(
      {super.key,
      required this.description,
      required this.heading,
      required this.subHeading,
      required this.isLifeTime});
  String heading;
  String subHeading;
  String description;
  bool isLifeTime;

  @override
  State<SubscriptionWidget> createState() => _SubscriptionwidgetState();
}

class _SubscriptionwidgetState extends State<SubscriptionWidget> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isActive) {
            isActive = false;
          } else {
            isActive = true;
          }
        });
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color:
                        isActive ? AppColor.yellowColor : Colors.amber.shade100,
                    width: 1),
                color: Colors.amber.shade100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.heading,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColor.yellowColor),
                ),
                Text(
                  widget.subHeading,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
          if (isActive)
            Positioned(
              right: 40,
              child: Image.asset(
                "assets/images/premium.png",
                width: 30,
                height: 30,
              ),
            )
        ],
      ),
    );
  }
}
