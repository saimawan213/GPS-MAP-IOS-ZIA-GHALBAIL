import 'package:flutter/material.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';


class CardViewIos extends StatelessWidget {
  final String imageUrl;
  final String labelText;

  CardViewIos({required this.imageUrl, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.0),
      decoration: BoxDecoration(
        color: AppColor.greyColor,
        // borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(),
          CircleAvatar(
              backgroundColor:AppColor.yellowColor,
              radius: 25.0, // Adjust the radius as needed
              child:
              Image(
                width: 30,
                height: 30,
                color: Colors.black,

                image: AssetImage(imageUrl), // Replace with the correct asset path
              )),
          /*ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white, // Change this color to the desired color
                BlendMode.srcIn,
              ),
              child: Image.asset(imageUrl),
              //backgroundImage: AssetImage(imageUrl),
          )),*/
          /* Container(
            //   width: 100, // Set your desired width for the circle
            //  height: 100, // Set your desired height for the circle
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: CircleAvatar(
              radius: 40.0, // Adjust the radius as needed
          //    backgroundImage: NetworkImage(imageUrl),
            ),
          ),*/
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: AppColor.greyColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),  // Bottom-left corner
                bottomRight: Radius.circular(12.0), // Bottom-right corner
              ), // Adjust the radius as needed
              /*  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],*/
            ),

            //  color: Colors.green,
            child: Text(
              labelText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.yellowColor,
                fontSize: 12.0,
              ),
            ),
          ),
/*
          Expanded(
            flex: 1,
            child: Container(
              //  margin: const EdgeInsets.all(5),



            ),
          ),
          Expanded(
            flex: 8,
            child:  Container(
              //   width: 100, // Set your desired width for the circle
              //  height: 100, // Set your desired height for the circle
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 40.0, // Adjust the radius as needed
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
          ),

          SizedBox(height: 8.0),
          Expanded(
            flex: 1,
            child: Container(
              //  margin: const EdgeInsets.all(5),



            ),
          ),
          Expanded(
            flex: 3,
            child:
              //  margin: const EdgeInsets.all(5),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),  // Bottom-left corner
                    bottomRight: Radius.circular(12.0), // Bottom-right corner
                  ), // Adjust the radius as needed
                //  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],*//*
                ),

               color: Colors.green,
                child: Text(
                  labelText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),



          ),*/

        ],
      ),
    );
  }
}