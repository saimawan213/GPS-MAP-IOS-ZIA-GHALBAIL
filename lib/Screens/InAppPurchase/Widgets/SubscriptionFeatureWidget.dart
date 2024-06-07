import 'package:flutter/material.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';

class SubscriptionFeatureWidget extends StatelessWidget {
  const SubscriptionFeatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: AppColor.yellowColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "100% Ads Free",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
