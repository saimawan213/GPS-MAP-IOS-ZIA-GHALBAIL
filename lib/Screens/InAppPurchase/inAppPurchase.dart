import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/InAppPurchase/InAppPurchaseViewModel.dart';

import '../../Widgets/TextButtonWidget.dart';
import '../Ads/Colors.dart';
import 'Widgets/SubscriptionFeatureWidget.dart';
import 'Widgets/SubscriptionWidget.dart';

class inAppPurchase extends StatelessWidget {
  InAppPurchaseViewModel viewModel = Get.put(InAppPurchaseViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () {
      //       // Add your back button onPressed logic here
      //       Navigator.pop(context);
      //       // Get.to(() => ExitScreen_View());
      //     },
      //   ),
      //   title: const Text("In App Purchase",
      //       style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.blue,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      'assets/images/SubscriptionScreen.jpeg',
                      height: Get.height * 0.3,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          Text(
                            "Got To Premium",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Upgrade to Premium & Get",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColor.yellowColor),
                          ),
                        ],
                      )),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.yellowColor,
                            shape: BoxShape.circle),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              SubscriptionFeatureWidget(),
              SubscriptionWidget(
                description:
                    "Cancel Subscription at least 24 hours before renewal",
                heading: "Life Time",
                subHeading: "Rs.3700/ Life Time",
                isLifeTime: true,
              ),
              Spacer(),
              Center(
                child: TextButtonWidget(
                  width: Get.width * 0.8,
                  height: Get.height * 0.1,
                  onPressedFunction: () {},
                  text: "Get this Package",
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Restore Purchases",
                      style:
                          TextStyle(color: AppColor.yellowColor, fontSize: 14),
                    )),
              ),

              Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Subscription Policy",
                    style: TextStyle(
                        color: AppColor.yellowColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  )),

              Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Billing Begins When You Opt for a Subscription, User Can cancel subscription within 24 hours of Purchase, Monthly Subscription will automatically Renews until User Cancel it. User can cancel anytime in Apple Account.",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Restore Purchases",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.yellowColor),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Restore Purchases",
                        style: TextStyle(
                            color: AppColor.yellowColor, fontSize: 14),
                      )),
                ],
              ),
              // Image.asset("assets/images/SubscriptionScreen.jpeg"),
              // Expanded(
              //   flex: 2,
              //   child: Container(
              //       /* child: Lottie.asset(
              //         'assets/lottie/adspurchase.json',
              //         height: 50.0,
              //         repeat: true,
              //         reverse: true,
              //         animate: true,
              //       ),*/
              //       /* margin: EdgeInsets.all(10),
              //       child: Column(
              //
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text("Click on Price Button to Remove all Ads From the App",
              //                 style: TextStyle(color: Colors.blue)),
              //           ),
              //           TextButton(
              //             onPressed: () {
              //               viewModel.buyLifeTimeSubscription();
              //               // Add your action here
              //             },
              //             child: Text(viewModel.price),
              //             style: TextButton.styleFrom(
              //               primary: Colors.white, // Text and icon color
              //               backgroundColor: Colors.blue, // Button background color
              //             ),),
              //         ],
              //       ),*/
              //       /*TextButton(
              //         style: TextButton.styleFrom(
              //           // backgroundColor: Colors.green[800],
              //           backgroundColor: Colors.blue,
              //           foregroundColor: Colors.white,
              //         ),
              //         onPressed: () async {
              //           viewModel.buyLifeTimeSubscription();
              //           // getPurchaseHistory();
              //           //  return;
              //
              //
              //
              //
              //           }, child: Text(viewModel.price),
              //
              //           //   getPurchaseHistory();
              //
              //        // child: Text(productDetails.price),
              //       ),*/
              //       ),
              // ),
              //
              /*  Expanded(
                    flex: 1,
                    child:
                    Container(
                    )
                ),*/
              // Expanded(
              //   flex: 1,
              //   child: Card(
              //     margin: EdgeInsets.all(10),
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //               "Click on Price Button to Remove all Ads From the App",
              //               style: TextStyle(color: Colors.blue)),
              //         ),
              //         TextButton(
              //           onPressed: () {
              //             viewModel.buyLifeTimeSubscription(context);
              //             // Add your action here
              //           },
              //           child: Text(viewModel.lifeTimePrice.value),
              //           style: TextButton.styleFrom(
              //             foregroundColor: Colors.white, // Text and icon color
              //             backgroundColor: Colors.blue, // Button background color
              //           ),
              //         ),
              //       ],
              //     ),
              //     /*TextButton(
              //       style: TextButton.styleFrom(
              //         // backgroundColor: Colors.green[800],
              //         backgroundColor: Colors.blue,
              //         foregroundColor: Colors.white,
              //       ),
              //       onPressed: () async {
              //         viewModel.buyLifeTimeSubscription();
              //         // getPurchaseHistory();
              //         //  return;
              //
              //
              //
              //
              //         }, child: Text(viewModel.price),
              //
              //         //   getPurchaseHistory();
              //
              //      // child: Text(productDetails.price),
              //     ),*/
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
